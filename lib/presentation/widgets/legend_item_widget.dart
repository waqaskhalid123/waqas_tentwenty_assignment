import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';

class LegendItemWidget extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItemWidget({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.asset(
            "assets/images/Seat.png",
            width: 18,
            height: 18,
            fit: BoxFit.contain,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: kStyle12400.copyWith(color: AppColors.greyText),
        ),
      ],
    );
  }
}
