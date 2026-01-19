import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_event.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_state.dart';
import 'package:ten_twenty_task/presentation/widgets/results_list.dart';
import 'package:ten_twenty_task/presentation/widgets/watch_search_bar.dart';

class WatchSearch extends StatelessWidget {
  const WatchSearch({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the globally provided SearchBloc from MyApp
    return const _WatchSearchView();
  }
}

class _WatchSearchView extends StatelessWidget {
  const _WatchSearchView();

  void _onSearchSubmitted(BuildContext context) {
    context.read<SearchBloc>().add(const SearchSubmitted());
  }

  void _onClearSearch(BuildContext context) {
    context.read<SearchBloc>().add(const SearchCleared());
  }

  void _onBackPressed(BuildContext context) {
    context.read<SearchBloc>().add(const SearchBackPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listenWhen: (previous, current) {
        // Only sync when transitioning from complete to searching state
        return previous.isSearchComplete && !current.isSearchComplete;
      },
      listener: (context, state) {
        // State is already managed by SearchBloc, no need to sync
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: state.isSearchComplete
                ? AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: AppColors.textDark,
                        size: 28,
                      ),
                      onPressed: () => _onBackPressed(context),
                    ),
                    title: Text(
                      '${state.searchResults.length} Results Found',
                      style: kStyle16500.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    centerTitle: false,
                  )
                : null,
            body: SafeArea(
              child: Column(
                children: [
                  if (!state.isSearchComplete)
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        return WatchSearchBar(
                          initialValue: state.searchQuery,
                          showClearButton: state.searchQuery.isNotEmpty,
                          onChanged: (query) {
                            context.read<SearchBloc>().add(
                                  SearchQueryChanged(query),
                                );
                          },
                          onClear: () => _onClearSearch(context),
                          onSubmitted: (_) => _onSearchSubmitted(context),
                        );
                      },
                    ),
                  Expanded(
                    child: resultsList(context, state),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
