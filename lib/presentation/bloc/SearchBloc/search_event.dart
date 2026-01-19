import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  const SearchSubmitted();
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

class SearchBackPressed extends SearchEvent {
  const SearchBackPressed();
}
