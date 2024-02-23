import 'package:marvel_app/constants.dart';
import 'package:marvel_app/core/error/exception.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters(int offset);
  Future<List<CharacterModel>> searchCharacter(String query);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {

  final hash =
    md5.convert(utf8.encode('1$privateApiKey$publicApiKey')).toString();
  @override
  Future<List<CharacterModel>> getAllCharacters(int offset) async {
    var response = await http.get(
      Uri.http('gateway.marvel.com', '/v1/public/characters', {
        'ts': '1',
        'apikey': publicApiKey,
        'hash': hash,
        'limit': '20',
        'offset': offset.toString(),
      }),
    );
    Map<String, dynamic> map =
        jsonDecode(response.body) as Map<String, dynamic>;
    List<CharacterModel> characters = [];
    if (response.statusCode == 200) {
      for (var characterData in map["data"]["results"]) {
        characters.add(CharacterModel.fromJson(characterData));
      }
      return characters;
    }
    throw ServerException();
  }

  @override
  Future<List<CharacterModel>> searchCharacter(String query) async {
    var response = await http.get(
      Uri.http('gateway.marvel.com', '/v1/public/characters', {
        'ts': '1',
        'apikey': publicApiKey,
        'hash': hash,
        'nameStartsWith': query,
      }),
    );
    Map<String, dynamic> map =
        jsonDecode(response.body) as Map<String, dynamic>;
    List<CharacterModel> characters = [];
    if (response.statusCode == 200) {
      for (var characterData in map["data"]["results"]) {
        characters.add(CharacterModel.fromJson(characterData));
      }
      return characters;
    }
    throw ServerException();
  }
}
