import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/check_favorite_character.dart';
import 'package:marvel_app/feature/domain/usecases/toogle_favorite_character.dart';

part 'favorite_character_event.dart';
part 'favorite_character_state.dart';

class FavoriteCharacterBloc
    extends Bloc<FavoriteCharacterEvent, FavoriteCharacterState> {
  final ToggleFavoriteCharacter toggleFavoriteCharacter;
  final CheckFavoriteCharacter checkFavoriteCharacter;

  FavoriteCharacterBloc(
      {required this.checkFavoriteCharacter,
      required this.toggleFavoriteCharacter})
      : super(FavoriteCharacterInitial()) {
    on<CheckCharacter>((event, emit) async {
      final isFavorite = await checkFavoriteCharacter(event.id);
      isFavorite.fold(
          (failure) => emit(FavoriteCharacterFailure()),
          (isFavorite) =>
              emit(FavoriteCharacterLoaded(isFavorite: isFavorite)));
    });

    on<ToggleCharacter>((event, emit) async {
      final isFavorite = await toggleFavoriteCharacter(event.character);
      isFavorite.fold(
          (failure) => emit(FavoriteCharacterFailure()),
          (isFavorite) =>
              emit(FavoriteCharacterLoaded(isFavorite: isFavorite)));
    });
  }
}
