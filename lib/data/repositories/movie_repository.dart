import 'dart:io';
import 'package:ten_twenty_task/data/local/database/app_database.dart';
import 'package:ten_twenty_task/data/local/database/mappers/movie_mapper.dart';
import 'package:ten_twenty_task/data/services/api_services.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

class MovieRepository {
  final AppDatabase _database;
  final APIServices _apiServices;

  MovieRepository({
    required AppDatabase database,
    required APIServices apiServices,
  })  : _database = database,
        _apiServices = apiServices;

  /// Get upcoming movies with cache-first strategy
  /// Returns cached data first, then fetches from API if online
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      // First, try to get cached data
      final cachedEntities = await _database.movieDao.getAllMovies();
      if (cachedEntities.isNotEmpty) {
        // Return cached data immediately
        final cachedMovies = MovieMapper.fromEntityList(cachedEntities);
        
        // Then try to fetch fresh data in background (non-blocking)
        _fetchAndCacheUpcomingMovies();
        
        return cachedMovies;
      }
      
      // No cache available, fetch from API
      return await _fetchAndCacheUpcomingMovies();
    } catch (e) {
      // If API fails, try to return cached data
      try {
        final cachedEntities = await _database.movieDao.getAllMovies();
        if (cachedEntities.isNotEmpty) {
          return MovieMapper.fromEntityList(cachedEntities);
        }
      } catch (_) {
        // Cache also failed
      }
      rethrow;
    }
  }

  Future<List<Movie>> _fetchAndCacheUpcomingMovies() async {
    try {
      final upcomingMoviesResponse = await _apiServices.getUpcomingMovies();
      final movies = upcomingMoviesResponse.results;

      // Clear old cache and insert new data
      await _database.movieDao.deleteAllMovies();
      final entities = MovieMapper.toEntityList(movies);
      await _database.movieDao.insertMovies(entities);

      return movies;
    } on SocketException {
      // Network error - return cached data if available
      final cachedEntities = await _database.movieDao.getAllMovies();
      if (cachedEntities.isNotEmpty) {
        return MovieMapper.fromEntityList(cachedEntities);
      }
      rethrow;
    }
  }

  /// Get a single movie by ID
  Future<Movie?> getMovieById(String id) async {
    try {
      // First check cache
      final cachedEntity = await _database.movieDao.getMovieById(id);
      if (cachedEntity != null) {
        return MovieMapper.fromEntity(cachedEntity);
      }
      // Could fetch from API if needed, but for now just return null
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear old cached movies (older than specified days)
  Future<void> clearOldCache({int days = 7}) async {
    final cutoffTime = DateTime.now()
        .subtract(Duration(days: days))
        .millisecondsSinceEpoch;
    await _database.movieDao.deleteOldMovies(cutoffTime);
  }
}
