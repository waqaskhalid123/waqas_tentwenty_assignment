class Movie {
  final String id;
  final String title;
  final String imagePath;
  final String? genre;
  final String? releaseDate;
  final String? overview;
  final List<String>? genres;
  final String? backdropPath;
  final List<int>? genreIds;

  const Movie({
    required this.id,
    required this.title,
    required this.imagePath,
    this.genre,
    this.releaseDate,
    this.overview,
    this.genres,
    this.backdropPath,
    this.genreIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'genre': genre,
      'releaseDate': releaseDate,
      'overview': overview,
      'genres': genres,
      'backdropPath': backdropPath,
      'genreIds': genreIds,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    // Handle TMDB API response structure
    final posterPath = map['poster_path'] as String?;
    final imagePath = posterPath != null
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : '';
    final backdropPath = map['backdrop_path'] as String?;
    
    // Parse genre_ids from API response
    final genreIdsList = map['genre_ids'] as List<dynamic>?;
    final List<int>? genreIds = genreIdsList != null
        ? genreIdsList.map((e) => e as int).toList()
        : null;
    
    return Movie(
      id: (map['id'] as int).toString(),
      title: map['title'] as String? ?? map['original_title'] as String? ?? '',
      imagePath: imagePath,
      genre: null, // Would need genre lookup from genre_ids
      releaseDate: map['release_date'] as String?,
      overview: map['overview'] as String?,
      genres: null, // Would need genre lookup from genre_ids
      backdropPath: backdropPath,
      genreIds: genreIds,
    );
  }
}
