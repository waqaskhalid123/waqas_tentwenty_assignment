import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';

class SelectSeatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String movieTitle;
  final String date;
  final String time;
  final String hall;
  final VoidCallback onBackPressed;

  const SelectSeatsAppBar({
    super.key,
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.hall,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/arrow_back_icon.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            AppColors.textDark,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onBackPressed,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movieTitle,
            style: kStyle18500.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$date | $time $hall',
            style: kStyle14400.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
