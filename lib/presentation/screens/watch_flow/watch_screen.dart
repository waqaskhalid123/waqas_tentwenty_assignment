import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_event.dart';
import 'package:ten_twenty_task/presentation/bloc/UpcomingMoviesBloc/upcoming_movies_state.dart';
import 'package:ten_twenty_task/presentation/widgets/movie_banner.dart';
import 'package:ten_twenty_task/presentation/widgets/watch_header.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  void initState() {
    super.initState();
    // Trigger fetch when page loads (will use cache first, then API)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpcomingMoviesBloc>().add(const FetchUpcomingMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const _WatchPageView();
  }
}

class _WatchPageView extends StatelessWidget {
  const _WatchPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            const WatchHeader(),
            Expanded(
              child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
                builder: (context, state) {
                  if (state is UpcomingMoviesLoading) {
                    // Show animated skeleton with placeholder items while loading
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: 5, // Show 5 skeleton items
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.3, end: 0.7),
                            duration: Duration(milliseconds: 1000 + (index * 200)),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return AnimatedOpacity(
                                opacity: value,
                                duration: const Duration(milliseconds: 800),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1 * value),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else if (state is UpcomingMoviesLoaded) {
                    if (state.movies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 80,
                              color: AppColors.greyText.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No upcoming movies found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pull down to refresh',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyText.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<UpcomingMoviesBloc>().add(
                              const FetchUpcomingMovies(),
                            );
                        // Wait a bit to show refresh indicator
                        await Future.delayed(const Duration(milliseconds: 800));
                      },
                      color: AppColors.primary,
                      strokeWidth: 3,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: state.movies.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 600 + (index * 150)),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              // Scale animation (starts small, grows to full size)
                              final scaleValue = 0.7 + (0.3 * value);
                              
                              // Slide up animation
                              final slideValue = 50.0 * (1 - value);
                              
                              // Rotation animation (subtle)
                              final rotationValue = (1 - value) * 0.1;
                              
                              return Opacity(
                                opacity: value,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(scaleValue)
                                    ..translate(0.0, slideValue)
                                    ..rotateZ(rotationValue),
                                  alignment: Alignment.center,
                                  child: child,
                                ),
                              );
                            },
                            child: AnimatedMovieBanner(movie: state.movies[index], index: index),
                          );
                        },
                      ),
                    );
                  } else if (state is UpcomingMoviesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 80,
                            color: Colors.red.withOpacity(0.7),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'Oops! Something went wrong',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              state.message.contains('SocketException') ||
                                      state.message.contains('network')
                                  ? 'Please check your internet connection'
                                  : state.message.length > 100
                                      ? state.message.substring(0, 100) + '...'
                                      : state.message,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<UpcomingMoviesBloc>().add(
                                    const FetchUpcomingMovies(),
                                  );
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No data available'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
