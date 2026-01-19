import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/data/model/movie_traier.dart';
import 'package:ten_twenty_task/data/repositories/trailer_repository.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
part 'watch_trailer_event.dart';
part 'watch_trailer_state.dart';

class WatchTrailerBloc extends Bloc<WatchTrailerEvent, WatchTrailerState> {
  final TrailerRepository _trailerRepository;
  YoutubePlayerController? controller;
  
  WatchTrailerBloc(this._trailerRepository) : super(const WatchTrailerInitial()) {
    on<GetMoviesTrailersFromMoviesEvent>((event, emit) async {
      try {
        final s = state as WatchTrailerInitial;
        emit(s.copyWith(isLoading: true));
        
        // Repository handles cache-first strategy and offline support
        final MovieTrailer trailer =
            await _trailerRepository.getMovieVideos(event.movie.id);
        final youtubeVideos = trailer.results
            .where((e) => e.site.toLowerCase() == "youtube".toLowerCase())
            .toList();
            
        if (youtubeVideos.isEmpty) {
          emit(s.copyWith(
              isLoading: false,
              hasError: true,
              errorMessage: "No YouTube trailers available"));
          return;
        }
        
        controller = YoutubePlayerController(
          initialVideoId: youtubeVideos.first.key,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            showLiveFullscreenButton: false,
            enableCaption: false,
            hideControls: true,
            disableDragSeek: true,
            controlsVisibleAtStart: false,
            startAt: 0,
            mute: false,
          ),
        );
        controller!.play();
        emit(s.copyWith(
            isLoading: false, trailer: trailer, controller: controller));
      } catch (e) {
        final s = state as WatchTrailerInitial;
        emit(s.copyWith(
            isLoading: false, hasError: true, errorMessage: e.toString()));
        log("Error getting trailers : $e");
      }
    });

  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
