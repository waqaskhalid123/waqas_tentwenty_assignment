import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/themes/app_themes.dart';
import 'package:ten_twenty_task/data/local/database/app_database.dart';
import 'package:ten_twenty_task/data/repositories/movie_repository.dart';
import 'package:ten_twenty_task/data/repositories/search_repository.dart';
import 'package:ten_twenty_task/data/repositories/trailer_repository.dart';
import 'package:ten_twenty_task/data/services/api_services.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/watch_trailer/watch_trailer_bloc.dart';
import 'package:ten_twenty_task/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static AppDatabase? _database;
  static MovieRepository? _movieRepository;
  static TrailerRepository? _trailerRepository;
  static SearchRepository? _searchRepository;
  
  static Future<void> initialize() async {
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final apiServices = APIServices.instance;
    _movieRepository = MovieRepository(
      database: _database!,
      apiServices: apiServices,
    );
    _trailerRepository = TrailerRepository(
      database: _database!,
      apiServices: apiServices,
    );
    _searchRepository = SearchRepository(
      database: _database!,
      apiServices: apiServices,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure database is initialized
    if (_database == null ||
        _movieRepository == null ||
        _trailerRepository == null ||
        _searchRepository == null) {
      throw Exception(
        'Database not initialized. Call MyApp.initialize() before runApp()',
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(create: (context) => SeatSelectionCubit()),
        BlocProvider(
          create: (context) => UpcomingMoviesBloc(_movieRepository!),
        ),
        BlocProvider(
          create: (context) => WatchTrailerBloc(_trailerRepository!),
        ),
        BlocProvider(
          create: (context) => SearchBloc(_searchRepository!),
        ),
      ],
      child: MaterialApp(
        title: 'Ten Twenty Task',
        theme: lightTheme,
        highContrastTheme: lightTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: NamedRoutes.dashboard.path,
      ),
    );
  }
}
