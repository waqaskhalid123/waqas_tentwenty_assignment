import 'package:floor/floor.dart';
import 'package:ten_twenty_task/data/local/database/entities/video_entity.dart';

@dao
abstract class VideoDao {
  @Query('SELECT * FROM videos WHERE movie_id = :movieId ORDER BY cached_at DESC')
  Future<List<VideoEntity>> getVideosByMovieId(String movieId);

  @Query('SELECT * FROM videos WHERE movie_id = :movieId AND site = :site')
  Future<List<VideoEntity>> getVideosByMovieIdAndSite(String movieId, String site);

  @insert
  Future<void> insertVideo(VideoEntity video);

  @insert
  Future<void> insertVideos(List<VideoEntity> videos);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateVideo(VideoEntity video);

  @delete
  Future<void> deleteVideo(VideoEntity video);

  @Query('DELETE FROM videos WHERE movie_id = :movieId')
  Future<void> deleteVideosByMovieId(String movieId);

  @Query('DELETE FROM videos')
  Future<void> deleteAllVideos();

  @Query('DELETE FROM videos WHERE cached_at < :timestamp')
  Future<void> deleteOldVideos(int timestamp);
}
