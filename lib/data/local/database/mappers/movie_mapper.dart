import 'dart:convert';
import 'package:ten_twenty_task/data/local/database/entities/movie_entity.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

class MovieMapper {
  static MovieEntity toEntity(Movie movie) {
    return MovieEntity(
      id: movie.id,
      title: movie.title,
      imagePath: movie.imagePath,
      genre: movie.genre,
      releaseDate: movie.releaseDate,
      overview: movie.overview,
      backdropPath: movie.backdropPath,
      genreIds: movie.genreIds != null ? jsonEncode(movie.genreIds) : null,
      genres: movie.genres != null ? jsonEncode(movie.genres) : null,
      cachedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  static Movie fromEntity(MovieEntity entity) {
    return Movie(
      id: entity.id,
      title: entity.title,
      imagePath: entity.imagePath,
      genre: entity.genre,
      releaseDate: entity.releaseDate,
      overview: entity.overview,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds != null
          ? List<int>.from(jsonDecode(entity.genreIds!))
          : null,
      genres: entity.genres != null
          ? List<String>.from(jsonDecode(entity.genres!))
          : null,
    );
  }

  static List<Movie> fromEntityList(List<MovieEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }

  static List<MovieEntity> toEntityList(List<Movie> movies) {
    return movies.map((movie) => toEntity(movie)).toList();
  }
}
