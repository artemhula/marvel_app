import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/usecases/search_character.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc
    extends Bloc<SearchCharacterEvent, SearchCharacterState> {
  final SearchCharacter searchCharacter;

  SearchCharacterBloc({required this.searchCharacter})
      : super(SearchCharacterInitial()) {
    on<LoadSearchCharacter>((event, emit) async {
      emit(SearchCharacterLoading());
      final characters = await searchCharacter.call(event.query);
      characters.fold((failure) => emit(SearchCharacterFailure()),
          (characters) => emit(SearchCharacterLoaded(characters)));
    });
  }
}
