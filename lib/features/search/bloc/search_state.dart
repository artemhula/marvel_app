part of 'search_bloc.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  SearchLoaded(this.characters);

  final List<Character> characters;
}

class SearchFailure extends SearchState {}
