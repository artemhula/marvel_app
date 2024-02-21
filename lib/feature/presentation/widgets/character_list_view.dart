
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/try_again_button.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state is CharacterListLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.red));
        }
        if (state is CharacterListLoaded) {
          return ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: state.characters.length + 1,
            itemBuilder: (context, i) => i < state.characters.length
                ? CharacterCard(
                    name: state.characters[i].name,
                    description: state.characters[i].description,
                    image: state.characters[i].image,
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Center(child: CircularProgressIndicator(color: Colors.red)),
                  ),
          );
        }
        if (state is CharacterListFailure) {
          return Center(
              child: Column(
            children: [
              const Text('Error'),
              const Text('Something went wrong'),
              TryAgainButton(
                function: () {
                  context
                      .read<CharacterListBloc>()
                      .add(LoadCharacterList());
                },
              ),
            ],
          ));
        }
        return Container();
      },
    );
  }
}
