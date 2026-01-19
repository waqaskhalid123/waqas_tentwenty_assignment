import 'package:floor/floor.dart';

@Entity(tableName: 'videos')
class VideoEntity {
  @primaryKey
  final String id;
  @ColumnInfo(name: 'movie_id')
  final String movieId;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String key;
  final String site;
  final int? size;
  final String? type;
  final bool official;
  @ColumnInfo(name: 'published_at')
  final int? publishedAt; // Timestamp in milliseconds
  @ColumnInfo(name: 'cached_at')
  final int cachedAt; // Timestamp in milliseconds

  VideoEntity({
    required this.id,
    required this.movieId,
    this.iso6391,
    this.iso31661,
    this.name,
    required this.key,
    required this.site,
    this.size,
    this.type,
    required this.official,
    this.publishedAt,
    required this.cachedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movieId': movieId,
      'iso6391': iso6391,
      'iso31661': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'publishedAt': publishedAt,
      'cachedAt': cachedAt,
    };
  }

  factory VideoEntity.fromMap(Map<String, dynamic> map) {
    return VideoEntity(
      id: map['id'] as String,
      movieId: map['movieId'] as String,
      iso6391: map['iso6391'] as String?,
      iso31661: map['iso31661'] as String?,
      name: map['name'] as String?,
      key: map['key'] as String,
      site: map['site'] as String,
      size: map['size'] as int?,
      type: map['type'] as String?,
      official: (map['official'] as int) == 1,
      publishedAt: map['publishedAt'] as int?,
      cachedAt: map['cachedAt'] as int,
    );
  }
}
