import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/repositories/marvel_characters/characters_repository.dart';
import 'package:marvel_app/repositories/marvel_characters/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CharactersRepository _charactersRepository = CharactersRepository();
  SearchBloc() : super(SearchInitial()) {
    on<LoadSearchEvent>((event, emit) async {
      var characters = await _charactersRepository.getCharactersByName(name: event.name);
      emit(SearchLoaded(characters));
    });
  }
}
