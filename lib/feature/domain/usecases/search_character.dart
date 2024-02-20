import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class SearchCharacter {
  final CharacterRepository characterRepository;

  SearchCharacter(this.characterRepository);
  Future<Either<Failure, List<CharacterEntity>>> call(String query) async {
    return await characterRepository.searchCharacter(query);
  }
}
