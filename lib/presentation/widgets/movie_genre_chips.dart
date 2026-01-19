import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';

class MovieGenreChips extends StatelessWidget {
  final List<String> genres;

  const MovieGenreChips({
    super.key,
    required this.genres,
  });

  // Map genre names to colors from AppColors
  Color _getGenreColor(String genre) {
    final genreLower = genre.toLowerCase();
    if (genreLower.contains('action')) {
      return AppColors.colors[4]; // Color(0xff15D2BC) - teal/cyan
    } else if (genreLower.contains('thriller')) {
      return AppColors.colors[5]; // Color(0xffE26CA5) - pink/magenta
    } else if (genreLower.contains('science')) {
      return AppColors.colors[6]; // Color(0xff564CA3) - purple
    } else if (genreLower.contains('fiction')) {
      return AppColors.colors[7]; // Color(0xffCD9D0F) - gold/orange
    }
    // Default color if genre doesn't match
    return AppColors.colors[2]; // primary color
  }

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Genres',
            style: kStyle16500.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 32,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return Container(
                margin: EdgeInsets.only(
                  right: index < genres.length - 1 ? 8 : 0,
                ),
                child: Chip(
                  label: Text(
                    genre,
                    style: kStyle12600.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: _getGenreColor(genre),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
