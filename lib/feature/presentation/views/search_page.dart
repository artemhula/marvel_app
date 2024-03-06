import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/search_character_cubit/search_character_cubit.dart';
import 'package:marvel_app/feature/presentation/widgets/go_back_button.dart';
import 'package:marvel_app/feature/presentation/widgets/search_character_list.dart';
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
                      .read<SearchCharacterCubit>()
                      .loadSearchCharacter(query);
                });
              }
            }),
            const SizedBox(height: 15),
            SearchCharacterList(),
          ],
        ),
      ),
    );
  }
}
