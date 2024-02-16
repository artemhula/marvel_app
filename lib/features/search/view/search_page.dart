import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/features/search/bloc/search_bloc.dart';
import 'package:marvel_app/features/search/widgets/widgets.dart';

//TODO разобраться откуда импортировать
import '../../character_list/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc _searchBloc = SearchBloc();

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
                _searchBloc.add(LoadSearchEvent(query));
              },
            ),
            const SizedBox(height: 15),
            BlocBuilder<SearchBloc, SearchState>(
              bloc: _searchBloc,
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Text(
                    'Who are we looking for?',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  );
                }
                if (state is SearchLoaded) {
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
                if (state is SearchFailure) {
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
