import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:ten_twenty_task/data/repositories/movie_repository.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_event.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_state.dart';

class UpcomingMoviesBloc extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final MovieRepository _movieRepository;

  UpcomingMoviesBloc(this._movieRepository) : super(const UpcomingMoviesInitial()) {
    on<FetchUpcomingMovies>(_onFetchUpcomingMovies);
  }

  Future<void> _onFetchUpcomingMovies(
    FetchUpcomingMovies event,
    Emitter<UpcomingMoviesState> emit,
  ) async {
    try {
      // Only show loading if we don't have cached data
      if (state is! UpcomingMoviesLoaded || 
          (state as UpcomingMoviesLoaded).movies.isEmpty) {
        emit(const UpcomingMoviesLoading());
      }
      // Repository handles cache-first strategy and offline support
      final movies = await _movieRepository.getUpcomingMovies();
      emit(UpcomingMoviesLoaded(movies));
    } catch (e) {
      log("Error fetching upcoming movies: $e");
      // If error but we have cached data, keep showing it
      if (state is UpcomingMoviesLoaded) {
        // Don't change state, keep showing cached data
        return;
      }
      emit(UpcomingMoviesError(e.toString()));
    }
  }
}
