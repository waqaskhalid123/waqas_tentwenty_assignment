import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/movie_details_screen.dart';

class SearchResultItem extends StatelessWidget {
  final Movie movie;

  const SearchResultItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if imagePath is a network URL or local asset
    final isNetworkImage = movie.imagePath.startsWith('http');

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MovieDetailsScreen(movie: movie),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      splashColor: AppColors.primary.withOpacity(0.1),
      highlightColor: AppColors.primary.withOpacity(0.05),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            // Thumbnail image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: isNetworkImage
                  ? CachedNetworkImage(
                      imageUrl: movie.imagePath,
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 120,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 120,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    )
                  : Image.asset(
                      movie.imagePath,
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
            ),
            const SizedBox(width: 15),
            // Title and genre
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: kStyle16500.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (movie.genre != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      movie.genre!,
                      style: kStyle14400.copyWith(
                        color: AppColors.greyText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Three dots menu
            InkWell(
              onTap: () {
                // TODO: Show menu options
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/images/more_options_icon.svg',
                  width: 4,
                  height: 4,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
