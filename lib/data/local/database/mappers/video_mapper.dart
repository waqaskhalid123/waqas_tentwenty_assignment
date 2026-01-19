import 'package:ten_twenty_task/data/local/database/entities/video_entity.dart';
import 'package:ten_twenty_task/data/model/movie_traier.dart';

class VideoMapper {
  static VideoEntity toEntity(VideoData video, String movieId) {
    return VideoEntity(
      id: video.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      movieId: movieId,
      iso6391: video.iso6391,
      iso31661: video.iso31661,
      name: video.name,
      key: video.key,
      site: video.site,
      size: video.size,
      type: video.type,
      official: video.official,
      publishedAt: video.publishedAt?.millisecondsSinceEpoch,
      cachedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  static VideoData fromEntity(VideoEntity entity) {
    return VideoData(
      iso6391: entity.iso6391,
      iso31661: entity.iso31661,
      name: entity.name,
      key: entity.key,
      site: entity.site,
      size: entity.size,
      type: entity.type,
      official: entity.official,
      publishedAt: entity.publishedAt != null
          ? DateTime.fromMillisecondsSinceEpoch(entity.publishedAt!)
          : null,
      id: entity.id,
    );
  }

  static List<VideoData> fromEntityList(List<VideoEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }

  static List<VideoEntity> toEntityList(List<VideoData> videos, String movieId) {
    return videos.map((video) => toEntity(video, movieId)).toList();
  }
}
