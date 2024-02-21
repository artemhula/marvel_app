import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/get_all_characters.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final GetAllCharacters getAllCharacters;

  List<CharacterEntity> characters = [];

  CharacterListBloc({required this.getAllCharacters})
      : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      if (characters.isEmpty) {
        emit(CharacterListLoading());
      }

      final newCharacters = await getAllCharacters(characters.length);
      newCharacters.fold((failure) {
        emit(CharacterListFailure());
      }, (newCharacters) {
        characters = characters + newCharacters;
        emit(CharacterListLoaded(characters));
      });
    });
  }
}
