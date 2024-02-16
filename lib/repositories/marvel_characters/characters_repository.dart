import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:marvel_app/repositories/marvel_characters/models/models.dart';

import 'package:marvel_app/constants.dart';

final hash =
    md5.convert(utf8.encode('1$privateApiKey$publicApiKey')).toString();

class CharactersRepository {
  Future<List<Character>> getCharacters({int offset = 0}) async {
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
    List<Character> characters = [];
    if (map["code"] == 200) {
      for (var characterData in map["data"]["results"]) {
        characters.add(Character.fromjson(characterData));
      }
      return characters;
    }
    throw Exception(map["code"]);
  }

  Future<List<Character>> getCharactersByName({required String name}) async {
    var response = await http.get(
      Uri.http('gateway.marvel.com', '/v1/public/characters', {
        'ts': '1',
        'apikey': publicApiKey,
        'hash': hash,
        'nameStartsWith': name,
        'limit': '50'
      }),
    );
    Map<String, dynamic> map =
        jsonDecode(response.body) as Map<String, dynamic>;
    List<Character> characters = [];
    if (map["code"] == 200) {
      for (var characterData in map["data"]["results"]) {
        characters.add(Character.fromjson(characterData));
      }
      return characters;
    }
    throw Exception(map["code"]);
  }
}
