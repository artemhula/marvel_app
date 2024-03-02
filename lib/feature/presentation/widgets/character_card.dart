import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/core/constants/style_constants.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_bloc/favorite_character_bloc.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_bloc/favorite_character_list_bloc.dart';
import 'package:marvel_app/feature/presentation/views/character_page.dart';
import 'package:marvel_app/feature/presentation/widgets/more_info_button.dart';

class CharacterCard extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String image;

  const CharacterCard(
      {super.key,
      required this.id,
      required this.name,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            context.read<FavoriteCharacterBloc>().add(CheckCharacter(id: id));
            return CharacterPage(
              id: id,
              image: image,
              name: name,
              description: description,
            );
          },
        );
        context
            .read<FavoriteCharacterListBloc>()
            .add(GetFavoriteCharacterList());
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 7),
            )
          ],
        ),
        height: 230,
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 160,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                        value: progress.progress, color: Colors.red)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8, bottom: 8, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kLargeTextStyle,
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: MoreInfoButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
