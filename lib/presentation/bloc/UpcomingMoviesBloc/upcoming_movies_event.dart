import 'package:equatable/equatable.dart';

sealed class UpcomingMoviesEvent extends Equatable {
  const UpcomingMoviesEvent();

  @override
  List<Object?> get props => [];
}

final class FetchUpcomingMovies extends UpcomingMoviesEvent {
  const FetchUpcomingMovies();
}
