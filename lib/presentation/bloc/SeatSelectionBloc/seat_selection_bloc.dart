import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/data/model/seat_model.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_state.dart';

class SeatSelectionCubit extends Cubit<SeatSelectionState> {
  SeatSelectionCubit() : super(SeatSelectionState.initial());

  void toggleSeat(int row, int seatNumber) {
    final updatedSeats = state.seats.map((rowList) {
      return rowList.map((seat) {
        if (seat.row == row && seat.number == seatNumber) {
          if (seat.type == SeatType.notAvailable) {
            return seat; // Can't select unavailable seats
          }
          return seat.copyWith(isSelected: !seat.isSelected);
        }
        return seat;
      }).toList();
    }).toList();

    final selectedSeats = <Seat>[];
    for (var rowList in updatedSeats) {
      for (var seat in rowList) {
        if (seat.isSelected) {
          selectedSeats.add(seat);
        }
      }
    }

    emit(state.copyWith(
      seats: updatedSeats,
      selectedSeats: selectedSeats,
    ));
  }

  void removeSeat(int row, int seatNumber) {
    final updatedSeats = state.seats.map((rowList) {
      return rowList.map((seat) {
        if (seat.row == row && seat.number == seatNumber) {
          return seat.copyWith(isSelected: false);
        }
        return seat;
      }).toList();
    }).toList();

    final selectedSeats = state.selectedSeats.where((seat) {
      return !(seat.row == row && seat.number == seatNumber);
    }).toList();

    emit(state.copyWith(
      seats: updatedSeats,
      selectedSeats: selectedSeats,
    ));
  }

  void zoomIn() {
    if (state.zoomLevel < 2.0) {
      emit(state.copyWith(zoomLevel: state.zoomLevel + 0.1));
    }
  }

  void zoomOut() {
    if (state.zoomLevel > 0.5) {
      emit(state.copyWith(zoomLevel: state.zoomLevel - 0.1));
    }
  }
}