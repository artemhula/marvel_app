import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> charactersToCache(List<CharacterModel> characters);
  Future<List<CharacterModel>> getLastCharacters();
  Future<List<CharacterModel>> searchCharacters(String query);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Box<Map<String, dynamic>> _box;

  CharacterLocalDataSourceImpl(this._box);
  @override
  Future<void> charactersToCache(List<CharacterModel> characters) async {
    await _box.clear();
    final List<Map<String, dynamic>> characterMaps =
        characters.map((character) => character.toJson()).toList();
    await _box.addAll(characterMaps);
  }

  @override
  Future<List<CharacterModel>> getLastCharacters() async {
    final List<Map<String, dynamic>> characterMaps = _box.values.toList();
    final List<CharacterModel> characters = characterMaps
        .map((characterMap) => CharacterModel.fromJson(characterMap))
        .toList();
    return characters;
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    final List<Map<String, dynamic>> characterMaps = _box.values
        .where((character) => character['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    final List<CharacterModel> characters = characterMaps
        .map((characterMap) => CharacterModel.fromJson(characterMap))
        .toList();
    return characters;
  }
}
