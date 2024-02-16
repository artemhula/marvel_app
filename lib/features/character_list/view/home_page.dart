import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/features/character_list/bloc/character_list_bloc.dart';
import 'package:marvel_app/features/character_list/widgets/widgets.dart';
import 'package:marvel_app/features/search/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _characterListBloc = CharacterListBloc();

  @override
  void initState() {
    super.initState();
    _characterListBloc.add(LoadCharacterList());
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        _characterListBloc.add(LoadMoreCharacterList());
      }
    });
  }

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
        padding: EdgeInsets.only(left: 25, top: 10, right: 25),
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
              child: BlocBuilder<CharacterListBloc, CharacterListState>(
                bloc: _characterListBloc,
                builder: (context, state) {
                  if (state is CharacterListLoaded) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: state.hasReachedMax
                          ? state.characters.length
                          : state.characters.length + 1,
                      itemBuilder: (context, i) => i < state.characters.length
                          ? CharacterCard(
                              name: state.characters[i].name,
                              description: state.characters[i].description,
                              image: state.characters[i].image,
                            )
                          : const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.red),
                              ),
                            ),
                    );
                  }
                  if (state is CharacterListFailure) {
                    return Center(
                        child: Column(
                      children: [
                        const Text('Error'),
                        const Text('Something went wrong'),
                        TryAgainButton(function: () {
                          _characterListBloc.add(LoadCharacterList());
                        },),
                      ],
                    ));
                  }
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.red));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
