import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';

class BottomNavConfig {
  BottomNavConfig._();

  static const String basePath = 'assets/images';

  static String getSvgPath(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.dashboard:
        return '$basePath/home_icon.svg';
      case BottomNavItem.watch:
        return '$basePath/watch_icon.svg';
      case BottomNavItem.mediaLibrary:
        return '$basePath/media_library.svg';
      case BottomNavItem.more:
        return '$basePath/more_icon.svg';
    }
  }

  static String getLabel(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.dashboard:
        return 'Dashboard';
      case BottomNavItem.watch:
        return 'Watch';
      case BottomNavItem.mediaLibrary:
        return 'Media Library';
      case BottomNavItem.more:
        return 'More';
    }
  }

  static List<BottomNavItem> get allItems => BottomNavItem.values;
}
