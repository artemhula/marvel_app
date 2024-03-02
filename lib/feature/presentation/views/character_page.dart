import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/core/constants/style_constants.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_bloc/favorite_character_bloc.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.description,
  });

  final int id;
  final String image;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCharacterBloc, FavoriteCharacterState>(
      builder: (context, state) {
        if (state is FavoriteCharacterLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          );
        }
        if (state is FavoriteCharacterLoaded) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.antiAlias,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.95)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ).createShader(bounds),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 3),
                        width: 50,
                        child: Divider(
                          color: Colors.black.withOpacity(0.7),
                          thickness: 5,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40, left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: kLargeTextStyle,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<FavoriteCharacterBloc>().add(
                                      ToggleCharacter(
                                        character: CharacterModel(
                                          id: id,
                                          name: name,
                                          description: description,
                                          image: image,
                                          url: 'google.com',
                                        ),
                                      ),
                                    );
                              },
                              child: state.isFavorite
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description == ''
                              ? 'There is no description'
                              : description,
                          style: kSmallTextStyle,
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (state is FavoriteCharacterFailure) {
          return const Center(child: Text('failure'));
        }
        return Container();
      },
    );
  }
}
