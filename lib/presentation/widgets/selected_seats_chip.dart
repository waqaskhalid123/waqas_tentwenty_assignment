import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';

class SelectedSeatsChip extends StatelessWidget {
  final String seatInfo;
  final VoidCallback? onRemove;

  const SelectedSeatsChip({
    super.key,
    required this.seatInfo,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            seatInfo,
            style: kStyle14600.copyWith(color: AppColors.textDark),
          ),
          if (onRemove != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.close, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}
