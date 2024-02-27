import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> charactersToCache(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCharacters(int offset);
  Future<List<CharacterModel>> searchCharacters(String query);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Box<CharacterModel> _box;

  CharacterLocalDataSourceImpl(this._box);
  @override
  Future<void> charactersToCache(List<CharacterModel> characters) async {
    await _box.clear();
    await _box.addAll(characters);
  }

  @override
  Future<List<CharacterModel>> getCharacters(int offset) async {
    List<CharacterModel> characters = _box.values.toList();

    final limit =
        offset + 20 > characters.length ? characters.length - offset : 20;

    characters = characters.skip(offset).take(limit).toList();

    return characters;
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    final List<CharacterModel> characters = _box.values
        .where((character) =>
            character.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return characters;
  }
}
