part of 'search_character_bloc.dart';

sealed class SearchCharacterEvent extends Equatable {
  const SearchCharacterEvent();

  @override
  List<Object> get props => [];
}

final class LoadSearchCharacter extends SearchCharacterEvent {
  const LoadSearchCharacter(this.query);

  final String query;
}
