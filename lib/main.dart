import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/views/home_page.dart';

import 'package:marvel_app/theme.dart';
import 'package:marvel_app/locator_service.dart';

import 'feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
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
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
