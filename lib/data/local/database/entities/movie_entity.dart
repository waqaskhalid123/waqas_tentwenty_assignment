import 'package:floor/floor.dart';

@Entity(tableName: 'movies')
class MovieEntity {
  @primaryKey
  final String id;
  final String title;
  final String imagePath;
  final String? genre;
  final String? releaseDate;
  final String? overview;
  final String? backdropPath;
  @ColumnInfo(name: 'genre_ids')
  final String? genreIds; // JSON string for List<int>
  @ColumnInfo(name: 'genres')
  final String? genres; // JSON string for List<String>
  @ColumnInfo(name: 'cached_at')
  final int cachedAt; // Timestamp in milliseconds

  MovieEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    this.genre,
    this.releaseDate,
    this.overview,
    this.backdropPath,
    this.genreIds,
    this.genres,
    required this.cachedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'genre': genre,
      'releaseDate': releaseDate,
      'overview': overview,
      'backdropPath': backdropPath,
      'genreIds': genreIds,
      'genres': genres,
      'cachedAt': cachedAt,
    };
  }

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      imagePath: map['imagePath'] as String,
      genre: map['genre'] as String?,
      releaseDate: map['releaseDate'] as String?,
      overview: map['overview'] as String?,
      backdropPath: map['backdropPath'] as String?,
      genreIds: map['genreIds'] as String?,
      genres: map['genres'] as String?,
      cachedAt: map['cachedAt'] as int,
    );
  }
}
