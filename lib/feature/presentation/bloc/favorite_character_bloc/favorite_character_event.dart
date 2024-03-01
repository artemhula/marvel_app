part of 'favorite_character_bloc.dart';

sealed class FavoriteCharacterEvent extends Equatable {
  const FavoriteCharacterEvent();

  @override
  List<Object> get props => [];
}

final class CheckCharacter extends FavoriteCharacterEvent {
  const CheckCharacter({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}

final class ToggleCharacter extends FavoriteCharacterEvent {
  const ToggleCharacter({required this.character});
  final CharacterEntity character;

  @override
  List<Object> get props => [character];
}
