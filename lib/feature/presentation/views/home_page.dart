import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/views/search_page.dart';
import 'package:marvel_app/feature/presentation/widgets/character_list_view.dart';

enum Route { characters, comics }

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        final state = context.read<CharacterListBloc>().state;
        if (state is CharacterListLoaded) {
          context.read<CharacterListBloc>().add(LoadCharacterList());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
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
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const SearchPage()));
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
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                  child: const Text('Popular'),
                ),
                TextButton(onPressed: () {}, child: const Text('A - Z')),
                TextButton(onPressed: () {}, child: const Text('Last viewed')),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CharacterListView(scrollController: _scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
