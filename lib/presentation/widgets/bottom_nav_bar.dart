import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_state.dart';
import 'package:ten_twenty_task/presentation/config/bottom_nav_config.dart';
import 'package:ten_twenty_task/presentation/widgets/bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.bottomNavBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: BottomNavConfig.allItems.map((item) {
              return bottomNavBarItem(
                context: context,
                svgAsset: BottomNavConfig.getSvgPath(item),
                label: BottomNavConfig.getLabel(item),
                item: item,
                isSelected: state.selectedTab == item,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}