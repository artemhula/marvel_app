import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/try_again_button.dart';

class CharacterList extends StatelessWidget {
  CharacterList({super.key});

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        final state = context.read<CharacterListCubit>().state;
        if (state is CharacterListLoaded) {
          context.read<CharacterListCubit>().loadCharacters();
        }
      }
    });
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return BlocBuilder<CharacterListCubit, CharacterListState>(
      builder: (context, state) {
        if (state is CharacterListLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
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
                    id: state.characters[i].id,
                    name: state.characters[i].name,
                    description: state.characters[i].description,
                    image: state.characters[i].image,
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Center(
                        child: CircularProgressIndicator(color: Colors.red)),
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
                  context.read<CharacterListCubit>().loadCharacters();
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
