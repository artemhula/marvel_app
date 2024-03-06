import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_cubit/favorite_character_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_cubit/favorite_character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_cubit/search_character_cubit.dart';
import 'package:marvel_app/feature/presentation/views/home_page.dart';

import 'package:marvel_app/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MarvelApp());
}

class MarvelApp extends StatelessWidget {
  const MarvelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterListCubit>(
          create: (context) => sl<CharacterListCubit>()..loadCharacters(),
        ),
        BlocProvider<SearchCharacterCubit>(
          create: (context) => sl<SearchCharacterCubit>(),
        ),
        BlocProvider<FavoriteCharacterCubit>(
          create: (context) => sl<FavoriteCharacterCubit>(),
        ),
        BlocProvider<FavoriteCharacterListCubit>(
          create: (context) => sl<FavoriteCharacterListCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
