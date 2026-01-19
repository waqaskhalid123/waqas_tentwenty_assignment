import 'package:flutter/material.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:ten_twenty_task/presentation/screens/Theater_Flow/select_seats_screen.dart';
import 'package:ten_twenty_task/presentation/screens/Theater_Flow/theater_selection_screen.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/main_shell.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/movie_details_screen.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/watch_search.dart';
import 'package:ten_twenty_task/presentation/screens/watch_flow/watch_trailer_screen.dart';

class AppRoutes {
  AppRoutes._();

  static final instance = AppRoutes._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings: settings,
          builder: (context) => const MainShell(),
        );

      case '/watch-movies-details-view':
        final movie = settings.arguments as Movie?;
        if (movie == null) {
          return _buildRoute(
            settings: settings,
            builder: (context) => const Scaffold(
              body: Center(child: Text('Movie not found')),
            ),
          );
        }
        return _buildRoute(
          settings: settings,
          builder: (context) => MovieDetailsScreen(movie: movie),
        );

      case '/watch-trailer-view':
        final movie = settings.arguments as Movie?;
        if (movie == null) {
          return _buildRoute(
            settings: settings,
            builder: (context) => const Scaffold(
              body: Center(child: Text('Movie not found')),
            ),
          );
        }
        return _buildRoute(
          settings: settings,
          builder: (context) => const WatchTrailerView(),
        );

      case '/watch-search':
        return _buildRoute(
          settings: settings,
          builder: (context) =>  WatchSearch(),
        );

      case '/theater-selection':
        final args = settings.arguments;
        if (args is Map) {
          final title = (args['title'] as String?) ?? 'Movie';
          final subtitle = args['subtitle'] as String?;
          return _buildRoute(
            settings: settings,
            builder: (context) => TheaterSelectionScreen(
              movieTitle: title,
              subtitle: subtitle,
            ),
          );
        }
        return _buildRoute(
          settings: settings,
          builder: (context) => const TheaterSelectionScreen(
            movieTitle: 'Movie',
          ),
        );

      case '/select-seats':
        final args = settings.arguments;
        if (args is Map) {
          final title = (args['title'] as String?) ?? 'Movie';
          final date = (args['date'] as String?) ?? 'Date';
          final time = (args['time'] as String?) ?? 'Time';
          final hall = (args['hall'] as String?) ?? 'Hall';
          return _buildRoute(
            settings: settings,
            builder: (context) => SelectSeatsScreen(
              movieTitle: title,
              date: date,
              time: time,
              hall: hall,
            ),
          );
        }
        return _buildRoute(
          settings: settings,
          builder: (context) =>  SelectSeatsScreen(
            movieTitle: 'Movie',
            date: 'Date',
            time: 'Time',
            hall: 'Hall',
          ),
        );

      default:
        return null;
    }
  }

  static Route<dynamic> _buildRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
    );
  }
}

enum NamedRoutes {
  dashboard('/'),
  watchAMovieDetailsView('/watch-movies-details-view'),
  watchTraillerView('/watch-trailer-view'),
  watchSearch('/watch-search'),
  theaterSelection('/theater-selection'),
  selectSeats('/select-seats');

  final String path;
  const NamedRoutes(this.path);
}
