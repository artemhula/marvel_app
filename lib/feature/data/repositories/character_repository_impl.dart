import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/error/exception.dart';
import 'package:marvel_app/core/error/failure.dart';
import 'package:marvel_app/core/platform/network_info.dart';
import 'package:marvel_app/feature/data/datasources/character_local_data_source.dart';
import 'package:marvel_app/feature/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/feature/domain/entities/character_entity.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
      int offset) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters =
            await remoteDataSource.getAllCharacters(offset);
        localDataSource.charactersToCache(remoteCharacters);
        return Right(remoteCharacters);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    try {
      final localCharacters = await localDataSource.getCharacters(offset);
      return Right(localCharacters);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await remoteDataSource.searchCharacter(query);
        localDataSource.charactersToCache(remoteCharacters);
        return Right(remoteCharacters);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    try {
      final localCharacters = await localDataSource.searchCharacters(query);
      return Right(localCharacters);
    } on ServerException {
      return Left(CacheFailure());
    }
  }
}
