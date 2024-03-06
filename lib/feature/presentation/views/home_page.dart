import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/core/constants/style_constants.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_cubit/favorite_character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/views/search_page.dart';
import 'package:marvel_app/feature/presentation/widgets/character_list.dart';
import 'package:marvel_app/feature/presentation/widgets/favorite_character_list.dart';

enum HomeRoute { all, favorite }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeRoute homeRoute = HomeRoute.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset(
            "assets/images/logo.png",
            height: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SearchPage()));
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset('assets/icons/search.png', width: 25),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      homeRoute = HomeRoute.all;
                    });
                  },
                  style: homeRoute == HomeRoute.all
                      ? kActiveButtonStyle
                      : kDefaultButtonStyle,
                  child: const Text('All'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      homeRoute = HomeRoute.favorite;
                    });
                  },
                  style: homeRoute == HomeRoute.favorite
                      ? kActiveButtonStyle
                      : kDefaultButtonStyle,
                  child: const Text('Favorite'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _chooseRoute(homeRoute),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chooseRoute(HomeRoute route) {
    if (route == HomeRoute.all) {
      return CharacterList();
    } else {
      context.read<FavoriteCharacterListCubit>().getFavoriteCharacterList();
      return FavoriteCharacterList();
    }
  }
}
