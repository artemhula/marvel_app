import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_bloc/bloc/search_character_bloc.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/go_back_button.dart';
import 'package:marvel_app/feature/presentation/widgets/search_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            SearchField(
              function: (query) {
                BlocProvider.of<SearchCharacterBloc>(context)
                    .add(LoadSearchCharacter(query));
              },
            ),
            const SizedBox(height: 15),
            BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
              builder: (context, state) {
                if (state is SearchCharacterInitial) {
                  return Text(
                    'Who are we looking for?',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  );
                }
                if (state is SearchCharacterLoaded) {
                  if (state.characters.isEmpty) {
                    return Text(
                      'Character not found',
                      style: GoogleFonts.inter(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        // controller: _scrollController,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: state.characters.length,
                        itemBuilder: (BuildContext context, i) {
                          return CharacterCard(
                            name: state.characters[i].name,
                            description: state.characters[i].description,
                            image: state.characters[i].image,
                          );
                        }),
                  );
                }
                if (state is SearchCharacterLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SearchCharacterFailure) {
                  return Text(
                    'ERR',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  );
                }
                return Text(
                  'SMTH WENT WRONG',
                  style: GoogleFonts.inter(
                      fontSize: 22, fontWeight: FontWeight.w600),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
