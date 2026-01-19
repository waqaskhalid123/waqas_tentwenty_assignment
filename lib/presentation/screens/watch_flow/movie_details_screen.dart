import 'package:flutter/material.dart';
import 'package:ten_twenty_task/core/extension/extension.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';
import 'package:ten_twenty_task/presentation/widgets/movie_details_header.dart';
import 'package:ten_twenty_task/presentation/widgets/movie_genre_chips.dart';
import 'package:ten_twenty_task/presentation/widgets/movie_overview_section.dart';
import 'package:ten_twenty_task/routes/app_routes.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  static Route<dynamic> route(Movie movie) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/watch-movies-details-view'),
      builder: (context) => MovieDetailsScreen(movie: movie),
    );
  }

  void _onGetTickets(BuildContext context) {
    Navigator.of(context).pushNamed(
      NamedRoutes.theaterSelection.path,
      arguments: {
        'title': movie.title,
        'subtitle': movie.releaseDate,
      },
    );
  }

  void _onWatchTrailer(BuildContext context) {
    Navigator.of(context).pushNamed(
      NamedRoutes.watchTraillerView.path,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Header with poster and buttons
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: MovieDetailsHeader(
                movie: movie,
                onGetTickets: () => _onGetTickets(context),
                onWatchTrailer: () => _onWatchTrailer(context),
              ),
            ),
          ),
          // Genres section
          if (movie.genreIds != null && movie.genreIds!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 24),
                child: MovieGenreChips(genres: movie.genreIds!.getGenreNamesList()),
              ),
            ),
          // Overview section
          if (movie.overview != null && movie.overview!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: MovieOverviewSection(overview: movie.overview!),
              ),
            ),
        ],
      ),
    );
  }
}
