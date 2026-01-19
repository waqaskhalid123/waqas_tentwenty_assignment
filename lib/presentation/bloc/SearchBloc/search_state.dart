import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/domain/entities/movie.dart';

class SearchState extends Equatable {
  final String searchQuery;
  final List<Movie> searchResults;
  final bool isSearchComplete;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.searchQuery = '',
    this.searchResults = const [],
    this.isSearchComplete = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SearchState copyWith({
    String? searchQuery,
    List<Movie>? searchResults,
    bool? isSearchComplete,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      isSearchComplete: isSearchComplete ?? this.isSearchComplete,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        searchResults,
        isSearchComplete,
        isLoading,
        errorMessage,
      ];
}
