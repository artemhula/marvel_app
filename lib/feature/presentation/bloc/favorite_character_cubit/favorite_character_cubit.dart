import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/check_favorite_character.dart';
import 'package:marvel_app/feature/domain/usecases/toogle_favorite_character.dart';

part 'favorite_character_state.dart';

class FavoriteCharacterCubit extends Cubit<FavoriteCharacterState> {
  final ToggleFavoriteCharacter toggleFavoriteCharacter;
  final CheckFavoriteCharacter checkFavoriteCharacter;

  FavoriteCharacterCubit(
      {required this.checkFavoriteCharacter,
      required this.toggleFavoriteCharacter})
      : super(FavoriteCharacterInitial());

  Future<void> checkCharacter(int id) async {
    final isFavorite = await checkFavoriteCharacter(id);
    isFavorite.fold((failure) => emit(FavoriteCharacterFailure()),
        (isFavorite) => emit(FavoriteCharacterLoaded(isFavorite: isFavorite)));
  }

  Future<void> toggleCharacter(CharacterEntity character) async {
    final isFavorite = await toggleFavoriteCharacter(character);
    isFavorite.fold((failure) => emit(FavoriteCharacterFailure()),
        (isFavorite) => emit(FavoriteCharacterLoaded(isFavorite: isFavorite)));
  }
}
