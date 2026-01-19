import 'dart:io';
import 'package:ten_twenty_task/data/local/database/app_database.dart';
import 'package:ten_twenty_task/data/local/database/mappers/movie_mapper.dart';
import 'package:ten_twenty_task/data/services/api_services.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

class SearchRepository {
  final AppDatabase _database;
  final APIServices _apiServices;

  SearchRepository({
    required AppDatabase database,
    required APIServices apiServices,
  })  : _database = database,
        _apiServices = apiServices;

  /// Search movies with cache-first strategy
  /// Returns cached results if available, then fetches from API
  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      // First, try to search in cached movies
      final allCachedMovies = await _database.movieDao.getAllMovies();
      final cachedResults = allCachedMovies
          .map((entity) => MovieMapper.fromEntity(entity))
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()) ||
              (movie.overview != null &&
                  movie.overview!.toLowerCase().contains(query.toLowerCase())))
          .toList();

      // If we have cached results, return them immediately
      // Then fetch fresh data in background
      if (cachedResults.isNotEmpty) {
        _searchAndCacheMovies(query);
        return cachedResults;
      }

      // No cache available, fetch from API
      return await _searchAndCacheMovies(query);
    } catch (e) {
      // If API fails, try to return cached results
      try {
        final allCachedMovies = await _database.movieDao.getAllMovies();
        final cachedResults = allCachedMovies
            .map((entity) => MovieMapper.fromEntity(entity))
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (cachedResults.isNotEmpty) {
          return cachedResults;
        }
      } catch (_) {
        // Cache also failed
      }
      rethrow;
    }
  }

  Future<List<Movie>> _searchAndCacheMovies(String query) async {
    try {
      final searchResponse = await _apiServices.searchMovies(query);
      final movies = searchResponse.results;

      // Cache the search results using batch insert with replace strategy
      if (movies.isNotEmpty) {
        final entities = MovieMapper.toEntityList(movies);
        try {
          // Insert with replace strategy handles both new and existing movies
          await _database.movieDao.insertMovies(entities);
        } catch (_) {
          // If batch insert fails, try individual inserts
          for (final entity in entities) {
            try {
              await _database.movieDao.insertMovie(entity);
            } catch (__) {
              // Ignore individual insert failures, continue with others
            }
          }
        }
      }

      return movies;
    } on SocketException {
      // Network error - return cached results if available
      try {
        final allCachedMovies = await _database.movieDao.getAllMovies();
        final cachedResults = allCachedMovies
            .map((entity) => MovieMapper.fromEntity(entity))
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (cachedResults.isNotEmpty) {
          return cachedResults;
        }
      } catch (_) {
        // Cache read failed
      }
      rethrow;
    } catch (e) {
      // Other errors - try to return cached results
      try {
        final allCachedMovies = await _database.movieDao.getAllMovies();
        final cachedResults = allCachedMovies
            .map((entity) => MovieMapper.fromEntity(entity))
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (cachedResults.isNotEmpty) {
          return cachedResults;
        }
      } catch (_) {
        // Cache read failed
      }
      rethrow;
    }
  }
}
