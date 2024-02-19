import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final String url;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.url,
  });

  @override
  List<Object?> get props => [id, name, description, image, url];
}
