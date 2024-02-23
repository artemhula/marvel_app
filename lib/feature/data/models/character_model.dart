import 'package:marvel_app/feature/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required id,
    required name,
    required description,
    required image,
    required url,
  }) : super(
            id: id,
            name: name,
            description: description,
            image: image,
            url: url);

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'] ?? json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
        url: 'google.com',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'url': url,
      };
}
