import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<BottomNavTabChanged>((event, emit) {
      // When switching tabs, close search if open
      emit(state.copyWith(
        selectedTab: event.tab,
        showWatchSearch: false,
      ));
    });
    on<WatchSearchToggled>((event, emit) {
      emit(state.copyWith(showWatchSearch: event.showSearch));
    });
  }
}