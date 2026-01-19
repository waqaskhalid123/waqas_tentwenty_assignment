part of 'watch_trailer_bloc.dart';

sealed class WatchTrailerState extends Equatable {
  const WatchTrailerState();

  @override
  List<Object> get props => [];
}

final class WatchTrailerInitial extends WatchTrailerState {
  final bool isLoading;
  final MovieTrailer? trailer;
  final bool hasError;
  final String errorMessage;
  final YoutubePlayerController? controller;

  const WatchTrailerInitial({
    this.isLoading = false,
    this.trailer,
    this.hasError = false,
    this.errorMessage = '',
    this.controller,
  });

  @override
  List<Object> get props => [
        isLoading,
        trailer ?? Object(),
        hasError,
        errorMessage,
        controller ?? Object(),
      ];

  WatchTrailerInitial copyWith({
    bool? isLoading,
    MovieTrailer? trailer,
    bool? hasError,
    String? errorMessage,
    YoutubePlayerController? controller,
  }) {
    return WatchTrailerInitial(
      isLoading: isLoading ?? this.isLoading,
      trailer: trailer ?? this.trailer,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      controller: controller ?? this.controller,
    );
  }
}
