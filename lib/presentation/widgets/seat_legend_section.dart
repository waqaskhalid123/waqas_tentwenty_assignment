import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_state.dart';
import 'package:ten_twenty_task/presentation/widgets/legend_item_widget.dart';

class SeatLegendSection extends StatelessWidget {
  const SeatLegendSection({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  LegendItemWidget(
                    color: AppColors.seatSelected,
                    text: "Selected",
                  ),
                  const SizedBox(width: 30),
                  LegendItemWidget(
                    color: AppColors.seatNotAvailable,
                    text: "Not available",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  LegendItemWidget(
                    color: AppColors.seatVip,
                    text: "VIP (150\$)",
                  ),
                  const SizedBox(width: 30),
                  LegendItemWidget(
                    color: AppColors.seatRegular,
                    text: "Regular (50\$)",
                  ),
                ],
              ),
             
                const SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(text: TextSpan(children: [
                            TextSpan(text: "4", style: kStyle14600.copyWith(color: AppColors.textDark)),
                            TextSpan(text: " / 3 row", style: kStyle12400.copyWith(color: AppColors.textDark)),
                          ])),
                          
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // Remove all selected seats
                              for (var seat in state.selectedSeats) {
                                context.read<SeatSelectionCubit>().removeSeat(
                                      seat.row,
                                      seat.number,
                                    );
                              }
                            },
                            child: const Icon(Icons.close, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              
            ],
          ),
        );
      },
    );
  }
}
