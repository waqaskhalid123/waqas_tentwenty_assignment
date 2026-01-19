import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';

class BottomNavState extends Equatable {
  final BottomNavItem selectedTab;
  final bool showWatchSearch;

  const BottomNavState({
    this.selectedTab = BottomNavItem.dashboard,
    this.showWatchSearch = false,
  });

  BottomNavState copyWith({
    BottomNavItem? selectedTab,
    bool? showWatchSearch,
  }) {
    return BottomNavState(
      selectedTab: selectedTab ?? this.selectedTab,
      showWatchSearch: showWatchSearch ?? this.showWatchSearch,
    );
  }

  @override
  List<Object?> get props => [selectedTab, showWatchSearch];
}