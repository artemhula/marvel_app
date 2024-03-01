import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class CheckFavoriteCharacter {
  final CharacterRepository characterRepository;

  CheckFavoriteCharacter(this.characterRepository);

  Future<Either<Failure, bool>> call(int id) async {
    return await characterRepository.checkFavoriteCharacter(id);
  }
}
