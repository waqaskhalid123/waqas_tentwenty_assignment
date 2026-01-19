import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/data/repositories/search_repository.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_event.dart';
import 'package:ten_twenty_task/presentation/bloc/SearchBloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;
  Timer? _debounceTimer;
  String _currentQuery = '';
  int _searchCounter = 0;

  SearchBloc(this._searchRepository) : super(const SearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
    on<SearchCleared>(_onSearchCleared);
    on<SearchBackPressed>(_onSearchBackPressed);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _currentQuery = '';
      emit(state.copyWith(
        searchQuery: '',
        searchResults: [],
        isSearchComplete: false,
        isLoading: false,
        errorMessage: null,
      ));
      return;
    }

    _currentQuery = query;
    final searchId = ++_searchCounter;

    // Show loading state immediately
    emit(state.copyWith(
      searchQuery: query,
      isLoading: true,
      errorMessage: null,
    ));

    // Debounce search using await within the event handler
    // This keeps emit valid throughout the async operation
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if query has changed, bloc is closed, or a new search started
    if (_currentQuery != query || isClosed || emit.isDone || searchId != _searchCounter) {
      return;
    }

    try {
      final results = await _searchRepository.searchMovies(query);

      // Only emit if query hasn't changed, bloc is not closed, emit is not done, and no new search
      if (_currentQuery == query && !isClosed && !emit.isDone && searchId == _searchCounter) {
        emit(state.copyWith(
          searchQuery: query,
          searchResults: results,
          isSearchComplete: false,
          isLoading: false,
          errorMessage: null,
        ));
      }
    } catch (e, stackTrace) {
      log("Error searching movies: $e", error: e, stackTrace: stackTrace);
      
      // Only emit error if query hasn't changed, bloc is not closed, emit is not done, and no new search
      if (_currentQuery == query && !isClosed && !emit.isDone && searchId == _searchCounter) {
        final errorMsg = e is DioException
            ? 'Network error: Unable to search movies. Please check your connection.'
            : 'Error searching movies: ${e.toString()}';
        
        emit(state.copyWith(
          searchQuery: query,
          searchResults: [],
          isLoading: false,
          errorMessage: errorMsg,
        ));
      }
    }
  }

  void _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) {
    if (state.searchQuery.isNotEmpty && state.searchResults.isNotEmpty) {
      emit(state.copyWith(isSearchComplete: true));
    }
  }

  void _onSearchCleared(
    SearchCleared event,
    Emitter<SearchState> emit,
  ) {
    _debounceTimer?.cancel();
    _currentQuery = '';
    _searchCounter++; // Increment to cancel any pending searches
    emit(const SearchState());
  }

  void _onSearchBackPressed(
    SearchBackPressed event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(isSearchComplete: false));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
