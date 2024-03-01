part of 'favorite_character_list_bloc.dart';

sealed class FavoriteCharacterListEvent extends Equatable {
  const FavoriteCharacterListEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteCharacterList extends FavoriteCharacterListEvent {}
