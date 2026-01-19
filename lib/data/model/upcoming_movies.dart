

import 'package:ten_twenty_task/data/model/dates.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart' show Movie;

class UpcomingMovies {
  final Dates dates;
  final int page;
  final List<Movie> results;
  UpcomingMovies({
    required this.dates,
    required this.page,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dates': dates.toMap(),
      'page': page,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory UpcomingMovies.fromMap(Map<String, dynamic> map) {
    return UpcomingMovies(
      dates: Dates.fromMap(map['dates'] as Map<String, dynamic>),
      page: map['page'] as int,
      results: List<Movie>.from(
        (map['results'] as List<dynamic>).map<Movie>(
          (x) => Movie.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}