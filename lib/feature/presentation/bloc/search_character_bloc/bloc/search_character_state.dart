part of 'search_character_bloc.dart';

sealed class SearchCharacterState extends Equatable {
  const SearchCharacterState();

  @override
  List<Object> get props => [];
}

final class SearchCharacterInitial extends SearchCharacterState {}

final class SearchCharacterLoading extends SearchCharacterState {}

final class SearchCharacterLoaded extends SearchCharacterState {
  const SearchCharacterLoaded(this.characters);
  final List<CharacterEntity> characters;
}

final class SearchCharacterFailure extends SearchCharacterState {}
