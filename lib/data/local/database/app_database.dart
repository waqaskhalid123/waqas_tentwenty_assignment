import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:ten_twenty_task/data/local/database/entities/movie_entity.dart';
import 'package:ten_twenty_task/data/local/database/entities/video_entity.dart';
import 'package:ten_twenty_task/data/local/database/daos/movie_dao.dart';
import 'package:ten_twenty_task/data/local/database/daos/video_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [MovieEntity, VideoEntity])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  VideoDao get videoDao;
}
