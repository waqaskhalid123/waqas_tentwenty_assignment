part of 'watch_trailer_bloc.dart';

sealed class WatchTrailerEvent extends Equatable {
  const WatchTrailerEvent();

  @override
  List<Object> get props => [];
}

final class GetMoviesTrailersFromMoviesEvent extends WatchTrailerEvent {
  final Movie movie;

  const GetMoviesTrailersFromMoviesEvent({required this.movie});
}
