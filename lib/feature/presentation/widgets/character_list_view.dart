import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_bloc/character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/try_again_button.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({
    super.key,
  });

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
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: state.characters.length,
              itemBuilder: (context, i) => CharacterCard(
                    name: state.characters[i].name,
                    description: state.characters[i].description,
                    image: state.characters[i].image,
                  ));
        }
        if (state is CharacterListFailure) {
          return Center(
              child: Column(
            children: [
              const Text('Error'),
              const Text('Something went wrong'),
              TryAgainButton(
                function: () {
                  // sl<CharacterListBloc>().add(LoadCharacterList);
                },
              ),
            ],
          ));
        }
        return const Center(
            child: CircularProgressIndicator(color: Colors.red));
      },
    );
  }
}
