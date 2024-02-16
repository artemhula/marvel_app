import 'package:flutter/material.dart';
import 'package:marvel_app/features/character_list/character_list.dart';

void main() {
  runApp(const MarvelApp());
}

class MarvelApp extends StatelessWidget {
  const MarvelApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
