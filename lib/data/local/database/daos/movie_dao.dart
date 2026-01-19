import 'package:floor/floor.dart';
import 'package:ten_twenty_task/data/local/database/entities/movie_entity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movies ORDER BY cached_at DESC')
  Future<List<MovieEntity>> getAllMovies();

  @Query('SELECT * FROM movies WHERE id = :id')
  Future<MovieEntity?> getMovieById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(MovieEntity movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(List<MovieEntity> movies);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(MovieEntity movie);

  @delete
  Future<void> deleteMovie(MovieEntity movie);

  @Query('DELETE FROM movies')
  Future<void> deleteAllMovies();

  @Query('DELETE FROM movies WHERE cached_at < :timestamp')
  Future<void> deleteOldMovies(int timestamp);
}
