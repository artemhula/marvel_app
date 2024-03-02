import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/core/constants/style_constants.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/go_back_button.dart';
import 'package:marvel_app/feature/presentation/widgets/search_field.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: const GoBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            SearchField(function: (query) {
              if (query.isNotEmpty) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                debounce = Timer(const Duration(milliseconds: 1000), () {
                  context
                      .read<SearchCharacterBloc>()
                      .add(LoadSearchCharacter(query));
                });
              }
            }),
            const SizedBox(height: 15),
            BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
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
            ),
          ],
        ),
      ),
    );
  }
}
