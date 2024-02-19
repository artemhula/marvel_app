part of 'character_list_bloc.dart';

sealed class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoading extends CharacterListState {}

class CharacterListLoaded extends CharacterListState {
  CharacterListLoaded(this.characters);

  final List<CharacterEntity> characters;
  // final bool hasReachedMax;
}

class CharacterListFailure extends CharacterListState {}
