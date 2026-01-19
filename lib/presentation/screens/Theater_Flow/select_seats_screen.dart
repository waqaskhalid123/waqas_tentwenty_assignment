import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_state.dart';
import 'package:ten_twenty_task/presentation/widgets/select_seats_app_bar.dart';
import 'package:ten_twenty_task/presentation/widgets/seat_image_viewer.dart';
import 'package:ten_twenty_task/presentation/widgets/seat_legend_section.dart';
import 'package:ten_twenty_task/presentation/widgets/select_seats_bottom_bar.dart';

class SelectSeatsScreen extends StatelessWidget {
  SelectSeatsScreen({
    super.key,
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.hall,
  });

  final String movieTitle;
  final String date;
  final String time;
  final String hall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectSeatsAppBar(
        movieTitle: movieTitle,
        date: date,
        time: time,
        hall: hall,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
        builder: (context, state) {
          return Column(
            children: [
              /// ================= Seat Image =================
              Expanded(
                child: SeatImageViewer(),
              ),

              /// ================= Legend =================
              SeatLegendSection(),

              const SizedBox(height: 16),

              /// ================= Bottom Bar =================
              SelectSeatsBottomBar(
                totalPrice: state.totalPrice,
                onProceedPressed: () {
                  // Handle proceed to pay
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
