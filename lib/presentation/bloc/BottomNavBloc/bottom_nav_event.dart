import 'package:equatable/equatable.dart';

enum BottomNavItem {
  dashboard,
  watch,
  mediaLibrary,
  more,
}

class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavTabChanged extends BottomNavEvent {
  final BottomNavItem tab;

  const BottomNavTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

class WatchSearchToggled extends BottomNavEvent {
  final bool showSearch;

  const WatchSearchToggled({required this.showSearch});

  @override
  List<Object?> get props => [showSearch];
}