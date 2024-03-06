import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/get_favorite_characters.dart';

part 'favorite_character_list_state.dart';

class FavoriteCharacterListCubit extends Cubit<FavoriteCharacterListState> {
  List<CharacterEntity> characters = [];
  final GetFavoriteCharacters getFavoriteCharacters;

  FavoriteCharacterListCubit({required this.getFavoriteCharacters})
      : super(FavoriteCharacterListInitial());

  Future<void> getFavoriteCharacterList() async {
    emit(FavoriteCharacterListLoading());
    final newCharacters = await getFavoriteCharacters();
    newCharacters.fold((failure) => emit(FavoriteCharacterListFailure()),
        (newCharacters) {
      characters = newCharacters;
      return emit(FavoriteCharacterListLoaded(characters: characters));
    });
  }
}
