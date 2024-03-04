
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/core/constants/style_constants.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';

class SearchCharacterList extends StatelessWidget {
  const SearchCharacterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
      builder: (context, state) {
        if (state is SearchCharacterInitial) {
          return Expanded(
            child: Center(
              child: Text(
                'Who are we looking for?',
                style: kMediumTextStyle,
              ),
            ),
          );
        }
        if (state is SearchCharacterLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          );
        }
        if (state is SearchCharacterLoaded) {
          if (state.characters.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  'Character not found',
                  style: kMediumTextStyle,
                ),
              ),
            );
          }
          return Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.characters.length,
                itemBuilder: (BuildContext context, i) {
                  return CharacterCard(
                    id: state.characters[i].id,
                    name: state.characters[i].name,
                    description: state.characters[i].description,
                    image: state.characters[i].image,
                  );
                }),
          );
        }
        if (state is SearchCharacterFailure) {
          return Text(
            'Error',
            style: kMediumTextStyle,
          );
        }
        return Container();
      },
    );
  }
}
