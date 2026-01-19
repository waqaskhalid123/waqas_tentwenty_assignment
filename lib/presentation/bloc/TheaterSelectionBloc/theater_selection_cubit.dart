import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/TheaterSelectionBloc/theater_selection_state.dart';

class TheaterSelectionCubit extends Cubit<TheaterSelectionState> {
  TheaterSelectionCubit() : super(TheaterSelectionState.initial());

  void selectDate(int index) {
    emit(state.copyWith(
      selectedDateIndex: index,
      selectedShowtimeIndex: 0,
    ));
  }

  void selectShowtime(int index) {
    emit(state.copyWith(selectedShowtimeIndex: index));
  }
}
