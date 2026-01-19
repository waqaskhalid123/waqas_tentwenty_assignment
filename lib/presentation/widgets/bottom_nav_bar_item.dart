import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';

  Widget bottomNavBarItem({
    required BuildContext context,
    required String svgAsset,
    required String label,
    required BottomNavItem item,
    required bool isSelected,
  }) {
    final color = isSelected
        ? AppColors.selectedBottomNavForeground
        : AppColors.unselectedBottomNavForeground;
    final textStyle = isSelected
        ? kStyle12500.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          )
        : kStyle12500.copyWith(
            color: color,
            fontWeight: FontWeight.w400,
          );

    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<BottomNavBloc>().add(BottomNavTabChanged(item));
        },
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  svgAsset,
                  width: 18,
                  height: 18,
                  colorFilter: isSelected
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : ColorFilter.mode(
                          color,
                          BlendMode.srcIn,
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
