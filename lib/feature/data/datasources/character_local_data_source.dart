import 'dart:convert';

import 'package:marvel_app/core/error/exception.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  Future<void> charactersToCache(List<CharacterModel> characters);
  Future<List<CharacterModel>> getLastCharacters();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> charactersToCache(List<CharacterModel> characters) {
    final List<String> jsonList =
        characters.map((character) => json.encode(character.toJson())).toList();
    sharedPreferences.setStringList('LAST_CHARACTERS', jsonList);
    return Future.value();
  }

  @override
  Future<List<CharacterModel>> getLastCharacters() {
    final List<String>? jsonList =
        sharedPreferences.getStringList('LAST_CHARACTERS');
    if (jsonList == null) {
      throw CacheException();
    } else {
      return Future.value(jsonList
          .map((character) => CharacterModel.fromJson(
              json.decode(character) as Map<String, dynamic>))
          .toList());
    }
  }
}
