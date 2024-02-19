import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/get_all_characters.dart';


part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final GetAllCharacters getAllCharacters;

  CharacterListBloc({required this.getAllCharacters}) : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      emit(CharacterListLoading());

      final characters = await getAllCharacters.call(0);
      characters.fold((failure) {
        emit(CharacterListFailure());
      }, (characters) {
        emit(CharacterListLoaded(characters));
      });
    });

    // on<LoadMoreCharacterList>((event, emit) async {
    //   hasReachedMax = true;
    //   characters +=
    //       await _charactersRepository.getCharacters(offset: characters.length);
    //   hasReachedMax = false;
    //   emit(CharacterListLoaded(characters, hasReachedMax));
    // });
  }
}
