import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class ToggleFavoriteCharacter {
  final CharacterRepository characterRepository;

  ToggleFavoriteCharacter(this.characterRepository);

  Future<Either<Failure, bool>> call(CharacterEntity character) async {
    return await characterRepository.toggleFavoriteCharacter(character);
  }
}
