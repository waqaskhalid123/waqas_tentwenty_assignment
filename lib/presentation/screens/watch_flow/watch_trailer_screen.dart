import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ten_twenty_task/core/extension/extension.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:ten_twenty_task/presentation/bloc/watch_trailer/watch_trailer_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailerView extends StatefulWidget {
  const WatchTrailerView({super.key});

  @override
  State<WatchTrailerView> createState() => _WatchTrailerViewState();
}

class _WatchTrailerViewState extends State<WatchTrailerView> {
  late final Movie movie;

  void initMovie() {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is Movie) {
      movie = routeArgs;
      BlocProvider.of<WatchTrailerBloc>(context)
          .add(GetMoviesTrailersFromMoviesEvent(movie: movie));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: const ButtonStyle().copyWith(
              minimumSize: const WidgetStatePropertyAll(Size(90, 40)),
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              side: const WidgetStatePropertyAll(BorderSide.none),
            ),
            label: const Text("Done"),
            icon: const Icon(CupertinoIcons.check_mark),
          ),
          const Gap(20),
        ],
      ),
      body: BlocConsumer<WatchTrailerBloc, WatchTrailerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WatchTrailerInitial) {
            final bool isLoading = state.isLoading;
            final YoutubePlayerController? controller = state.controller;
            if (isLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
              ));
            } else if (controller != null) {
              final backdropUrl = movie.backdropPath != null
                  ? movie.backdropPath!.getMovieThumbnail()
                  : movie.imagePath;
              return CachedNetworkImage(
                imageUrl: backdropUrl,
                imageBuilder: (ctx, provider) => Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: provider, fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        alignment: Alignment.center,
                        child: YoutubePlayer(
                          controller: controller,
                          onEnded: (metaData) => Navigator.of(context).pop(),
                          onReady: () => controller.play(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }
          return Container();
        },
      ),
    );
  }
}
