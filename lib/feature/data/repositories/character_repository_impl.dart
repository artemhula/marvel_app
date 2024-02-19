import 'package:dartz/dartz.dart';
import 'package:marvel_app/error/exception.dart';
import 'package:marvel_app/error/failure.dart';
import 'package:marvel_app/feature/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
      int offset) async {
    try {
      final characters =
          await remoteDataSource.getAllCharacters(offset);
      return Right(characters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(
      String query) async {
    try {
      final characters = await remoteDataSource.searchCharacter(query);
      return Right(characters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
