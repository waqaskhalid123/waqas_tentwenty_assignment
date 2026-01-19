import 'package:flutter/material.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_state.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/watch_screen.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/watch_search.dart';

Widget bodyForTab(BottomNavItem tab, BottomNavState state) {
  switch (tab) {
    case BottomNavItem.dashboard:
      return const Center(child: Text('Dashboard View'));
    case BottomNavItem.watch:
      // Show search if flag is true, otherwise show watch page
      return state.showWatchSearch
          ? const WatchSearch()
          : const WatchPage();
    case BottomNavItem.mediaLibrary:
      return const Center(child: Text('Media Library View'));
    case BottomNavItem.more:
      return const Center(child: Text('More View'));
  }
}