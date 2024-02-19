import 'package:flutter/material.dart';
import 'package:marvel_app/feature/presentation/views/character_page.dart';
import 'package:marvel_app/feature/presentation/widgets/more_info_button.dart';
import 'package:shimmer/shimmer.dart';


class CharacterCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const CharacterCard(
      {super.key,
      required this.name,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return CharacterPage(
                image: image, name: name, description: description);
          }),
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
        height: 210,
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 150,
              child: Image.network(
                image,
                fit: BoxFit.fitHeight,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.grey.shade200,
                            child: Container(
                                height: double.infinity,
                                width: 150,
                                color: Colors.black),
                          ),
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
                          //bodymedium
                          // style: GoogleFonts.inter(
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.w800,
                          //   fontSize: 26,
                          // ),
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          //body
                          style: Theme.of(context).textTheme.bodySmall,
                          // style: GoogleFonts.inter(
                          //     color: Colors.grey,
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w700),
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
