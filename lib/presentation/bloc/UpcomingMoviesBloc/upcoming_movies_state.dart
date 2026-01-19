import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

sealed class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object?> get props => [];
}

final class UpcomingMoviesInitial extends UpcomingMoviesState {
  const UpcomingMoviesInitial();
}

final class UpcomingMoviesLoading extends UpcomingMoviesState {
  const UpcomingMoviesLoading();
}

final class UpcomingMoviesLoaded extends UpcomingMoviesState {
  final List<Movie> movies;

  const UpcomingMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

final class UpcomingMoviesError extends UpcomingMoviesState {
  final String message;

  const UpcomingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
