import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class GetFavoriteCharacters {
  final CharacterRepository characterRepository;

  GetFavoriteCharacters(this.characterRepository);
  Future<Either<Failure, List<CharacterEntity>>> call() async {
    return await characterRepository.getFavoriteCharacters();
  }
}
