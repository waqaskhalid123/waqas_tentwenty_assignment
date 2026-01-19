import 'dart:io';
import 'package:ten_twenty_task/data/local/database/app_database.dart';
import 'package:ten_twenty_task/data/local/database/mappers/video_mapper.dart';
import 'package:ten_twenty_task/data/model/movie_traier.dart';
import 'package:ten_twenty_task/data/services/api_services.dart';

class TrailerRepository {
  final AppDatabase _database;
  final APIServices _apiServices;

  TrailerRepository({
    required AppDatabase database,
    required APIServices apiServices,
  })  : _database = database,
        _apiServices = apiServices;

  /// Get movie trailers with cache-first strategy
  /// Returns cached data first, then fetches from API if online
  Future<MovieTrailer> getMovieVideos(String movieId) async {
    try {
      // First, try to get cached data
      final cachedVideos = await _database.videoDao.getVideosByMovieId(movieId);
      if (cachedVideos.isNotEmpty) {
        // Return cached data immediately
        final videoData = VideoMapper.fromEntityList(cachedVideos);
        final cachedTrailer = MovieTrailer(
          id: int.parse(movieId),
          results: videoData,
        );
        
        // Then try to fetch fresh data in background (non-blocking)
        _fetchAndCacheMovieVideos(movieId);
        
        return cachedTrailer;
      }
      
      // No cache available, fetch from API
      return await _fetchAndCacheMovieVideos(movieId);
    } catch (e) {
      // If API fails, try to return cached data
      try {
        final cachedVideos = await _database.videoDao.getVideosByMovieId(movieId);
        if (cachedVideos.isNotEmpty) {
          final videoData = VideoMapper.fromEntityList(cachedVideos);
          return MovieTrailer(
            id: int.parse(movieId),
            results: videoData,
          );
        }
      } catch (_) {
        // Cache also failed
      }
      rethrow;
    }
  }

  Future<MovieTrailer> _fetchAndCacheMovieVideos(String movieId) async {
    try {
      final movieTrailer = await _apiServices.getMovieVideos(int.parse(movieId));
      
      // Clear old cache for this movie and insert new data
      await _database.videoDao.deleteVideosByMovieId(movieId);
      final entities = VideoMapper.toEntityList(movieTrailer.results, movieId);
      await _database.videoDao.insertVideos(entities);

      return movieTrailer;
    } on SocketException {
      // Network error - return cached data if available
      final cachedVideos = await _database.videoDao.getVideosByMovieId(movieId);
      if (cachedVideos.isNotEmpty) {
        final videoData = VideoMapper.fromEntityList(cachedVideos);
        return MovieTrailer(
          id: int.parse(movieId),
          results: videoData,
        );
      }
      rethrow;
    }
  }

  /// Get YouTube videos only (filtered from cache or API)
  Future<List<VideoData>> getYouTubeVideos(String movieId) async {
    final trailer = await getMovieVideos(movieId);
    return trailer.results
        .where((e) => e.site.toLowerCase() == "youtube".toLowerCase())
        .toList();
  }

  /// Clear old cached videos (older than specified days)
  Future<void> clearOldCache({int days = 7}) async {
    final cutoffTime = DateTime.now()
        .subtract(Duration(days: days))
        .millisecondsSinceEpoch;
    await _database.videoDao.deleteOldVideos(cutoffTime);
  }
}
