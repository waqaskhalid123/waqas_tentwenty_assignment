// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  VideoDao? _videoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movies` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `imagePath` TEXT NOT NULL, `genre` TEXT, `releaseDate` TEXT, `overview` TEXT, `backdropPath` TEXT, `genre_ids` TEXT, `genres` TEXT, `cached_at` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `videos` (`id` TEXT NOT NULL, `movie_id` TEXT NOT NULL, `iso6391` TEXT, `iso31661` TEXT, `name` TEXT, `key` TEXT NOT NULL, `site` TEXT NOT NULL, `size` INTEGER, `type` TEXT, `official` INTEGER NOT NULL, `published_at` INTEGER, `cached_at` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  VideoDao get videoDao {
    return _videoDaoInstance ??= _$VideoDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'imagePath': item.imagePath,
                  'genre': item.genre,
                  'releaseDate': item.releaseDate,
                  'overview': item.overview,
                  'backdropPath': item.backdropPath,
                  'genre_ids': item.genreIds,
                  'genres': item.genres,
                  'cached_at': item.cachedAt
                }),
        _movieEntityUpdateAdapter = UpdateAdapter(
            database,
            'movies',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'imagePath': item.imagePath,
                  'genre': item.genre,
                  'releaseDate': item.releaseDate,
                  'overview': item.overview,
                  'backdropPath': item.backdropPath,
                  'genre_ids': item.genreIds,
                  'genres': item.genres,
                  'cached_at': item.cachedAt
                }),
        _movieEntityDeletionAdapter = DeletionAdapter(
            database,
            'movies',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'imagePath': item.imagePath,
                  'genre': item.genre,
                  'releaseDate': item.releaseDate,
                  'overview': item.overview,
                  'backdropPath': item.backdropPath,
                  'genre_ids': item.genreIds,
                  'genres': item.genres,
                  'cached_at': item.cachedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  final UpdateAdapter<MovieEntity> _movieEntityUpdateAdapter;

  final DeletionAdapter<MovieEntity> _movieEntityDeletionAdapter;

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    return _queryAdapter.queryList(
        'SELECT * FROM movies ORDER BY cached_at DESC',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as String,
            title: row['title'] as String,
            imagePath: row['imagePath'] as String,
            genre: row['genre'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?,
            backdropPath: row['backdropPath'] as String?,
            genreIds: row['genre_ids'] as String?,
            genres: row['genres'] as String?,
            cachedAt: row['cached_at'] as int));
  }

  @override
  Future<MovieEntity?> getMovieById(String id) async {
    return _queryAdapter.query('SELECT * FROM movies WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as String,
            title: row['title'] as String,
            imagePath: row['imagePath'] as String,
            genre: row['genre'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?,
            backdropPath: row['backdropPath'] as String?,
            genreIds: row['genre_ids'] as String?,
            genres: row['genres'] as String?,
            cachedAt: row['cached_at'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM movies');
  }

  @override
  Future<void> deleteOldMovies(int timestamp) async {
    await _queryAdapter.queryNoReturn('DELETE FROM movies WHERE cached_at < ?1',
        arguments: [timestamp]);
  }

  @override
  Future<void> insertMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(
        movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMovies(List<MovieEntity> movies) async {
    await _movieEntityInsertionAdapter.insertList(
        movies, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateMovie(MovieEntity movie) async {
    await _movieEntityUpdateAdapter.update(movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMovie(MovieEntity movie) async {
    await _movieEntityDeletionAdapter.delete(movie);
  }
}

class _$VideoDao extends VideoDao {
  _$VideoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _videoEntityInsertionAdapter = InsertionAdapter(
            database,
            'videos',
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'movie_id': item.movieId,
                  'iso6391': item.iso6391,
                  'iso31661': item.iso31661,
                  'name': item.name,
                  'key': item.key,
                  'site': item.site,
                  'size': item.size,
                  'type': item.type,
                  'official': item.official ? 1 : 0,
                  'published_at': item.publishedAt,
                  'cached_at': item.cachedAt
                }),
        _videoEntityUpdateAdapter = UpdateAdapter(
            database,
            'videos',
            ['id'],
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'movie_id': item.movieId,
                  'iso6391': item.iso6391,
                  'iso31661': item.iso31661,
                  'name': item.name,
                  'key': item.key,
                  'site': item.site,
                  'size': item.size,
                  'type': item.type,
                  'official': item.official ? 1 : 0,
                  'published_at': item.publishedAt,
                  'cached_at': item.cachedAt
                }),
        _videoEntityDeletionAdapter = DeletionAdapter(
            database,
            'videos',
            ['id'],
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'movie_id': item.movieId,
                  'iso6391': item.iso6391,
                  'iso31661': item.iso31661,
                  'name': item.name,
                  'key': item.key,
                  'site': item.site,
                  'size': item.size,
                  'type': item.type,
                  'official': item.official ? 1 : 0,
                  'published_at': item.publishedAt,
                  'cached_at': item.cachedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VideoEntity> _videoEntityInsertionAdapter;

  final UpdateAdapter<VideoEntity> _videoEntityUpdateAdapter;

  final DeletionAdapter<VideoEntity> _videoEntityDeletionAdapter;

  @override
  Future<List<VideoEntity>> getVideosByMovieId(String movieId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM videos WHERE movie_id = ?1 ORDER BY cached_at DESC',
        mapper: (Map<String, Object?> row) => VideoEntity(
            id: row['id'] as String,
            movieId: row['movie_id'] as String,
            iso6391: row['iso6391'] as String?,
            iso31661: row['iso31661'] as String?,
            name: row['name'] as String?,
            key: row['key'] as String,
            site: row['site'] as String,
            size: row['size'] as int?,
            type: row['type'] as String?,
            official: (row['official'] as int) != 0,
            publishedAt: row['published_at'] as int?,
            cachedAt: row['cached_at'] as int),
        arguments: [movieId]);
  }

  @override
  Future<List<VideoEntity>> getVideosByMovieIdAndSite(
    String movieId,
    String site,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM videos WHERE movie_id = ?1 AND site = ?2',
        mapper: (Map<String, Object?> row) => VideoEntity(
            id: row['id'] as String,
            movieId: row['movie_id'] as String,
            iso6391: row['iso6391'] as String?,
            iso31661: row['iso31661'] as String?,
            name: row['name'] as String?,
            key: row['key'] as String,
            site: row['site'] as String,
            size: row['size'] as int?,
            type: row['type'] as String?,
            official: (row['official'] as int) != 0,
            publishedAt: row['published_at'] as int?,
            cachedAt: row['cached_at'] as int),
        arguments: [movieId, site]);
  }

  @override
  Future<void> deleteVideosByMovieId(String movieId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM videos WHERE movie_id = ?1',
        arguments: [movieId]);
  }

  @override
  Future<void> deleteAllVideos() async {
    await _queryAdapter.queryNoReturn('DELETE FROM videos');
  }

  @override
  Future<void> deleteOldVideos(int timestamp) async {
    await _queryAdapter.queryNoReturn('DELETE FROM videos WHERE cached_at < ?1',
        arguments: [timestamp]);
  }

  @override
  Future<void> insertVideo(VideoEntity video) async {
    await _videoEntityInsertionAdapter.insert(video, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertVideos(List<VideoEntity> videos) async {
    await _videoEntityInsertionAdapter.insertList(
        videos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateVideo(VideoEntity video) async {
    await _videoEntityUpdateAdapter.update(video, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteVideo(VideoEntity video) async {
    await _videoEntityDeletionAdapter.delete(video);
  }
}
