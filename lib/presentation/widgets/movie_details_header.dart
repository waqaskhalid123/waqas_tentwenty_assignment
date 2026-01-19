import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/extension/extension.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onBackPressed;
  final VoidCallback? onGetTickets;
  final VoidCallback? onWatchTrailer;

  const MovieDetailsHeader({
    super.key,
    required this.movie,
    this.onBackPressed,
    this.onGetTickets,
    this.onWatchTrailer,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Movie poster background
        CachedNetworkImage(
          imageUrl: movie.backdropPath?.getMovieThumbnail() ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported);
          },
        ),
        // Dark gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        // Navigation (top-left)
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed:
                        onBackPressed ?? () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'Watch',
                    style: kStyle16500.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Movie title and release date
        Positioned(
          left: 0,
          right: 0,
          bottom: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: kStyle18500.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              if (movie.releaseDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  movie.releaseDate!,
                  textAlign: TextAlign.center,
                  style: kStyle14400.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
        // Action buttons at bottom-center (narrower)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final buttonWidth =
                        (constraints.maxWidth * 0.78).clamp(240.0, 320.0);
                    return SizedBox(
                      width: buttonWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Get Tickets button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: onGetTickets,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Get Tickets',
                                style: kStyle14600.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Watch Trailer button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: onWatchTrailer,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                  color: AppColors.primary,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Watch Trailer',
                                    style: kStyle16500.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
