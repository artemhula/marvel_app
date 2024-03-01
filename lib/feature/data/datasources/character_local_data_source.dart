import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> charactersToCache(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCharacters(int offset);
  Future<List<CharacterModel>> searchCharacters(String query);
  Future<List<CharacterModel>> getFavoriteCharacters();
  Future<bool> addFavoriteCharacter(CharacterModel character);
  Future<bool> deleteFavoriteCharacter(int id);
  Future<bool> checkFavoriteCharacter(int id);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Box<CharacterModel> _characterListbox;
  final Box<CharacterModel> _favoriteCharacterListbox;

  CharacterLocalDataSourceImpl(
      this._characterListbox, this._favoriteCharacterListbox);
  @override
  Future<void> charactersToCache(List<CharacterModel> characters) async {
    await _characterListbox.clear();
    await _characterListbox.addAll(characters);
  }

  @override
  Future<List<CharacterModel>> getCharacters(int offset) async {
    List<CharacterModel> characters = _characterListbox.values.toList();

    final limit =
        offset + 20 > characters.length ? characters.length - offset : 20;

    characters = characters.skip(offset).take(limit).toList();

    return characters;
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    final List<CharacterModel> characters = _characterListbox.values
        .where((character) =>
            character.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return characters;
  }

  @override
  Future<List<CharacterModel>> getFavoriteCharacters() async {
    if (_favoriteCharacterListbox.isEmpty) {
      return [];
    }
    return _favoriteCharacterListbox.values.toList();
  }

  @override
  Future<bool> checkFavoriteCharacter(int id) async {
    return _favoriteCharacterListbox.containsKey(id);
  }

  @override
  Future<bool> addFavoriteCharacter(CharacterModel character) async {
    _favoriteCharacterListbox.put(character.id, character);
    return true;
  }

  @override
  Future<bool> deleteFavoriteCharacter(int id) async {
    _favoriteCharacterListbox.delete(id);
    return false;
  }
}
