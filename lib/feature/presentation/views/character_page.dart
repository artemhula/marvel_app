import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({
    super.key,
    required this.image,
    required this.name,
    required this.description,
  });

  final String image;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.antiAlias,
      // height: MediaQuery.of(context).size.height * 0.89,
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
                  Text(
                    name,
                    // style: GoogleFonts.inter(
                    //     fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description == '' ? 'There is no description' : description,
                    // style: GoogleFonts.inter(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black54),
                    style: Theme.of(context).textTheme.bodySmall,
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
}
