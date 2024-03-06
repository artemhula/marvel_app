part of 'character_list_cubit.dart';

sealed class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class CharacterListInitial extends CharacterListState {
  @override
  List<Object> get props => [];
}

class CharacterListLoading extends CharacterListState {

  @override
  List<Object> get props => [];
}

class CharacterListLoaded extends CharacterListState {
  const CharacterListLoaded(this.characters);

  final List<CharacterEntity> characters;
  @override
  List<Object> get props => [characters];
}

class CharacterListFailure extends CharacterListState {
  @override
  List<Object> get props => [];
}
