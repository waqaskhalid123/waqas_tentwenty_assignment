import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';

class SeatLegendWidget extends StatelessWidget {
  const SeatLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 16,
        runSpacing: 12,
        children: [
          _LegendItem(
            color: AppColors.seatSelected,
            label: 'Selected',
          ),
          _LegendItem(
            color: AppColors.seatNotAvailable,
            label: 'Not available',
          ),
          _LegendItem(
            color: AppColors.seatVip,
            label: 'VIP (150\$)',
          ),
          _LegendItem(
            color: AppColors.seatRegular,
            label: 'Regular (50\$)',
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: kStyle12400.copyWith(
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
