part of 'character_list_bloc.dart';

class CharacterListState {}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoading extends CharacterListState {}

class CharacterListLoaded extends CharacterListState {
  CharacterListLoaded(this.characters, this.hasReachedMax);

  final List<Character> characters;
  final bool hasReachedMax;
}

class CharacterListFailure extends CharacterListState {}
