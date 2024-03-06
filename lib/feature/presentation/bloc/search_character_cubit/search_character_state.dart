part of 'search_character_cubit.dart';

sealed class SearchCharacterState extends Equatable {
  const SearchCharacterState();

  @override
  List<Object> get props => [];
}

final class SearchCharacterInitial extends SearchCharacterState {
  @override
  List<Object> get props =>[];
}

final class SearchCharacterLoading extends SearchCharacterState {
@override
  List<Object> get props => [];
}

final class SearchCharacterLoaded extends SearchCharacterState {
  const SearchCharacterLoaded(this.characters);
  final List<CharacterEntity> characters;

  @override
  List<Object> get props => [characters];
}

final class SearchCharacterFailure extends SearchCharacterState {
  @override
  List<Object> get props => [];
}
