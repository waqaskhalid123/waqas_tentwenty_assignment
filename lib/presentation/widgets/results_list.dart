  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:ten_twenty_task/core/styles/app_colors.dart';
  import 'package:ten_twenty_task/core/styles/typography.dart';
  import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_bloc.dart';
  import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_event.dart';
  import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_state.dart';
  import 'package:ten_twenty_task/presentation/widgets/search_result_item.dart';

  Widget resultsList(BuildContext context, SearchState state) {
    if (state.searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: AppColors.greyText.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Search for movies',
              style: kStyle16500.copyWith(
                color: AppColors.greyText,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start typing to find your favorite movies',
              style: kStyle14400.copyWith(
                color: AppColors.greyText.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Searching...',
              style: kStyle14400.copyWith(
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.errorMessage!.contains('network') ||
                        state.errorMessage!.contains('SocketException')
                    ? 'Connection Error'
                    : 'Search Error',
                style: kStyle16500.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.errorMessage!.contains('network') ||
                        state.errorMessage!.contains('SocketException')
                    ? 'Please check your internet connection and try again'
                    : 'Something went wrong. Please try again.',
                style: kStyle14400.copyWith(
                  color: AppColors.greyText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<SearchBloc>().add(
                      SearchQueryChanged(state.searchQuery),
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

    if (state.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.greyText.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: kStyle16500.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: kStyle14400.copyWith(
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: AppColors.scaffoldBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!state.isSearchComplete) ...[
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.textInputBordered,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                'Top Results',
                style: kStyle16500.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: 20,
                top: state.isSearchComplete ? 16 : 0,
                right: 20,
                bottom: 16,
              ),
              itemCount: state.searchResults.length,
              itemBuilder: (context, index) {
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 200 + (index * 50)),
                  child: SearchResultItem(movie: state.searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }