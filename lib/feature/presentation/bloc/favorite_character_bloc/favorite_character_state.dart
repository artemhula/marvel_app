part of 'favorite_character_bloc.dart';

sealed class FavoriteCharacterState extends Equatable {
  const FavoriteCharacterState();

  @override
  List<Object> get props => [];
}

final class FavoriteCharacterInitial extends FavoriteCharacterState {}

final class FavoriteCharacterLoading extends FavoriteCharacterState {}

final class FavoriteCharacterLoaded extends FavoriteCharacterState {
  const FavoriteCharacterLoaded({required this.isFavorite});

  final bool isFavorite;

  @override
  List<Object> get props => [isFavorite];
}

final class FavoriteCharacterFailure extends FavoriteCharacterState {}
