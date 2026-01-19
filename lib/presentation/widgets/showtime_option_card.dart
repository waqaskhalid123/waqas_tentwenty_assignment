import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/widgets/seat_map_thumbnail.dart';

class ShowtimeOptionCard extends StatelessWidget {
  final String time;
  final String theaterAndHall;
  final int fromPrice;
  final int bonus;
  final bool isSelected;
  final VoidCallback? onTap;

  const ShowtimeOptionCard({
    super.key,
    required this.time,
    required this.theaterAndHall,
    required this.fromPrice,
    required this.bonus,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.primary : const Color(0xFFDBDBDF);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  time,
                  style: kStyle14400.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    theaterAndHall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kStyle14400.copyWith(
                      color: AppColors.greyText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SeatMapThumbnail(
                    width: double.infinity,
                    height: 120,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: kStyle14400.copyWith(color: AppColors.greyText),
                children: [
                  const TextSpan(text: 'From '),
                  TextSpan(
                    text: '${fromPrice}\$',
                    style: kStyle14600.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' or '),
                  TextSpan(
                    text: '$bonus bonus',
                    style: kStyle14600.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

