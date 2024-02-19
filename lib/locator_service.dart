import 'package:get_it/get_it.dart';
import 'package:marvel_app/feature/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/feature/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/feature/domain/repositories/character_repository.dart';
import 'package:marvel_app/feature/domain/usecases/get_all_characters.dart';
import 'package:marvel_app/feature/domain/usecases/search_character.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';

final sl = GetIt.instance;

initializeDependencies() {
  //bloc
  sl.registerFactory<CharacterListBloc>(
      () => CharacterListBloc(getAllCharacters: sl()));
  sl.registerFactory<SearchCharacterBloc>(
      () => SearchCharacterBloc(searchCharacter: sl()));

  //usecases
  sl.registerLazySingleton(() => SearchCharacter(sl()));
  sl.registerLazySingleton(() => GetAllCharacters(sl()));

  //repo
  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl());

  //core

  //ext
}
