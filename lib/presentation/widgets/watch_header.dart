import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';

class WatchHeader extends StatelessWidget {
  const WatchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final searchIconColor = AppColors.textDark;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEFEFEF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Watch',
            style: kStyle18500.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              context.read<BottomNavBloc>().add(
                    const WatchSearchToggled(showSearch: true),
                  );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/images/search.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  searchIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
