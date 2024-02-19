import 'package:dartz/dartz.dart';
import 'package:marvel_app/error/failure.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository characterRepository;

  GetAllCharacters(this.characterRepository);

  Future<Either<Failure, List<CharacterEntity>>> call(int offset) async {
    return await characterRepository.getAllCharacters(offset);
  }
}
