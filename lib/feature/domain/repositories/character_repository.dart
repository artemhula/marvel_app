import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(int offset);
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(String query);
  Future<Either<Failure, List<CharacterEntity>>> getFavoriteCharacters();
  Future<Either<Failure, bool>> toggleFavoriteCharacter(CharacterEntity character);
  Future<Either<Failure, bool>> checkFavoriteCharacter(int id);
}