import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_bloc/favorite_character_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_bloc/favorite_character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/views/home_page.dart';

import 'package:marvel_app/locator_service.dart';

import 'feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';

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
        BlocProvider<CharacterListBloc>(
          create: (context) =>
              sl<CharacterListBloc>()..add(LoadCharacterList()),
        ),
        BlocProvider<SearchCharacterBloc>(
          create: (context) => sl<SearchCharacterBloc>(),
        ),
         BlocProvider<FavoriteCharacterBloc>(
          create: (context) => sl<FavoriteCharacterBloc>(),
        ), BlocProvider<FavoriteCharacterListBloc>(
          create: (context) => sl<FavoriteCharacterListBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
