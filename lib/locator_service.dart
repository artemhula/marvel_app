import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:marvel_app/core/platform/network_info.dart';
import 'package:marvel_app/core/util/character_model_adapter.dart';
import 'package:marvel_app/feature/data/datasources/character_local_data_source.dart';
import 'package:marvel_app/feature/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';
import 'package:marvel_app/feature/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';
import 'package:marvel_app/feature/domain/usecases/check_favorite_character.dart';
import 'package:marvel_app/feature/domain/usecases/get_all_characters.dart';
import 'package:marvel_app/feature/domain/usecases/get_favorite_characters.dart';
import 'package:marvel_app/feature/domain/usecases/search_character.dart';
import 'package:marvel_app/feature/domain/usecases/toogle_favorite_character.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_cubit/favorite_character_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_cubit/favorite_character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_cubit/search_character_cubit.dart';

final sl = GetIt.instance;

Future initializeDependencies() async {
  //bloc
  sl.registerFactory<CharacterListCubit>(
      () => CharacterListCubit(getAllCharacters: sl()));
  sl.registerFactory<SearchCharacterCubit>(
      () => SearchCharacterCubit(searchCharacter: sl()));
  sl.registerFactory<FavoriteCharacterCubit>(() => FavoriteCharacterCubit(
        toggleFavoriteCharacter: sl(),
        checkFavoriteCharacter: sl(),
      ));
  sl.registerFactory<FavoriteCharacterListCubit>(
      () => FavoriteCharacterListCubit(getFavoriteCharacters: sl()));

  //usecases
  sl.registerLazySingleton(() => SearchCharacter(sl()));
  sl.registerLazySingleton(() => GetAllCharacters(sl()));
  sl.registerLazySingleton(() => GetFavoriteCharacters(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteCharacter(sl()));
  sl.registerLazySingleton(() => CheckFavoriteCharacter(sl()));

  //repo
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl());
  sl.registerLazySingleton<CharacterLocalDataSource>(
      () => CharacterLocalDataSourceImpl(
            sl.get<Box<CharacterModel>>(instanceName: 'charactersBox'),
            sl.get<Box<CharacterModel>>(instanceName: 'favoriteCharactersBox'),
          ));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //ext
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox<CharacterModel>('characters');
  sl.registerLazySingleton(() => Hive.box<CharacterModel>('characters'),
      instanceName: 'charactersBox');
  await Hive.openBox<CharacterModel>('favoriteCharacters');
  sl.registerLazySingleton(() => Hive.box<CharacterModel>('favoriteCharacters'),
      instanceName: 'favoriteCharactersBox');

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
