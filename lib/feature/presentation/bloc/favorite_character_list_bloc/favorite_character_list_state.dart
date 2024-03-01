part of 'favorite_character_list_bloc.dart';

sealed class FavoriteCharacterListState extends Equatable {
  const FavoriteCharacterListState();

  @override
  List<Object> get props => [];
}

final class FavoriteCharacterListInitial extends FavoriteCharacterListState {}

final class FavoriteCharacterListLoading extends FavoriteCharacterListState {}

final class FavoriteCharacterListLoaded extends FavoriteCharacterListState {
  FavoriteCharacterListLoaded({required this.characters});

  final List<CharacterEntity> characters;
}

final class FavoriteCharacterListFailure extends FavoriteCharacterListState {}
