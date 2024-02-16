import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/repositories/marvel_characters/characters_repository.dart';
import 'package:marvel_app/repositories/marvel_characters/models/models.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final CharactersRepository _charactersRepository = CharactersRepository();
  List<Character> characters = [];
  bool hasReachedMax = false;

  CharacterListBloc() : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      emit(CharacterListLoading());
      try {
        characters = await _charactersRepository.getCharacters();
        emit(CharacterListLoaded(characters, hasReachedMax));
      } catch (e) {
        emit(CharacterListFailure());
      }
    });

    on<LoadMoreCharacterList>((event, emit) async {
      hasReachedMax = true;
      characters +=
          await _charactersRepository.getCharacters(offset: characters.length);
      hasReachedMax = false;
      emit(CharacterListLoaded(characters, hasReachedMax));
    });
  }
}
