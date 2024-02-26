import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:marvel_app/core/platform/network_info.dart';
import 'package:marvel_app/feature/data/datasources/character_local_data_source.dart';
import 'package:marvel_app/feature/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/feature/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';
import 'package:marvel_app/feature/domain/usecases/get_all_characters.dart';
import 'package:marvel_app/feature/domain/usecases/search_character.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';

final sl = GetIt.instance;

Future initializeDependencies() async {
  //bloc
  sl.registerFactory<CharacterListBloc>(
      () => CharacterListBloc(getAllCharacters: sl()));
  sl.registerFactory<SearchCharacterBloc>(
      () => SearchCharacterBloc(searchCharacter: sl()));

  //usecases
  sl.registerLazySingleton(() => SearchCharacter(sl()));
  sl.registerLazySingleton(() => GetAllCharacters(sl()));

  //repo
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl());
  sl.registerLazySingleton<CharacterLocalDataSource>(
      () => CharacterLocalDataSourceImpl(sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //ext
  await Hive.openBox<Map<String, dynamic>>('characterList');
  sl.registerLazySingleton(() => Hive.box<Map<String, dynamic>>('characterList'));

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
