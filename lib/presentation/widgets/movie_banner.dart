import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:ten_twenty_task/presentation/bloc/MovieBannerBloc/movie_banner_cubit.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/movie_details_screen.dart';

class AnimatedMovieBanner extends StatelessWidget {
  final Movie movie;
  final int index;

  const AnimatedMovieBanner({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBannerCubit(),
      child: _AnimatedMovieBannerContent(movie: movie, index: index),
    );
  }
}

class _AnimatedMovieBannerContent extends StatelessWidget {
  final Movie movie;
  final int index;

  const _AnimatedMovieBannerContent({
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBannerCubit, double>(
      builder: (context, hoverValue) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: hoverValue == 0.0 ? 0.0 : 1.0, end: hoverValue),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          builder: (context, animationValue, child) {
            final scale = 1.0 - (animationValue * 0.05);
            final elevation = 4.0 + (animationValue * 8.0);

            return GestureDetector(
              onTapDown: (_) {
                context.read<MovieBannerCubit>().startHoverAnimation();
              },
              onTapUp: (_) {
                context.read<MovieBannerCubit>().stopHoverAnimation();
              },
              onTapCancel: () {
                context.read<MovieBannerCubit>().stopHoverAnimation();
              },
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MovieDetailsScreen(movie: movie),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOutCubic;

                      var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve),
                      );

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },

              child: Transform.scale(
                scale: scale,
                child: Hero(
                  tag: 'movie_${movie.id}',
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15 + (animationValue * 0.1)),
                          blurRadius: elevation * 2,
                          offset: Offset(0, elevation),
                          spreadRadius: animationValue * 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Movie image
                          _buildMovieImage(context),
                          // Bottom gradient overlay
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.3),
                                    Colors.black.withValues(alpha: 0.7),
                                    Colors.black.withValues(alpha: 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Movie title at bottom with animation
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: Duration(milliseconds: 500 + (index * 100)),
                              curve: Curves.easeOut,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(20 * (1 - value), 0),
                                  child: Opacity(
                                    opacity: value,
                                    child: Text(
                                      movie.title,
                                      style: kStyle16500.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.5),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Shimmer effect on hover
                          if (animationValue > 0)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white.withOpacity(0.0),
                                      Colors.white.withOpacity(0.1 * animationValue),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMovieImage(BuildContext context) {
    // Check if imagePath is a URL or local asset
    if (movie.imagePath.startsWith('http://') || 
        movie.imagePath.startsWith('https://')) {
      // Network image with fade animation
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 400 + (index * 80)),
        curve: Curves.easeIn,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: CachedNetworkImage(
              imageUrl: movie.imagePath,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xff61C3F2), // AppColors.primary
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          );
        },
      );
    } else {
      // Local asset
      return Image.asset(
        movie.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    }
  }
}

// Keep original MovieBanner for backward compatibility
class MovieBanner extends StatelessWidget {
  final Movie movie;

  const MovieBanner({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedMovieBanner(
      movie: movie,
      index: 0, // Default index for standalone usage
    );
  }
}
