import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/get_favorite_characters.dart';

part 'favorite_character_list_event.dart';
part 'favorite_character_list_state.dart';

class FavoriteCharacterListBloc
    extends Bloc<FavoriteCharacterListEvent, FavoriteCharacterListState> {
  List<CharacterEntity> characters = [];
  final GetFavoriteCharacters getFavoriteCharacters;

  FavoriteCharacterListBloc({required this.getFavoriteCharacters})
      : super(FavoriteCharacterListInitial()) {
    on<GetFavoriteCharacterList>((event, emit) async {
      emit(FavoriteCharacterListLoading());
      final newCharacters = await getFavoriteCharacters();
      newCharacters.fold((failure) => emit(FavoriteCharacterListFailure()),
          (newCharacters) {
        characters = newCharacters;
        return emit(FavoriteCharacterListLoaded(characters: characters));
      });
    });
  }
}
