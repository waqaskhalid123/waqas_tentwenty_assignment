import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_bloc.dart';

class ZoomButtonWidget extends StatelessWidget {
  final IconData icon;

  const ZoomButtonWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<SeatSelectionCubit>();
        if (icon == Icons.add) {
          cubit.zoomIn();
        } else if (icon == Icons.remove) {
          cubit.zoomOut();
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textDark),
      ),
    );
  }
}
