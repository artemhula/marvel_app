import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/search_character.dart';

part 'search_character_state.dart';

class SearchCharacterCubit extends Cubit<SearchCharacterState> {
  final SearchCharacter searchCharacter;

  List<CharacterEntity> characters = [];

  SearchCharacterCubit({required this.searchCharacter})
      : super(SearchCharacterInitial());

  Future<void> loadSearchCharacter(String query) async {
    emit(SearchCharacterLoading());
    final characters = await searchCharacter.call(query);
    characters.fold((failure) => emit(SearchCharacterFailure()),
        (characters) => emit(SearchCharacterLoaded(characters)));
  }
}