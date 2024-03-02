import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreInfoButton extends StatelessWidget {
  const MoreInfoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "More info",
          style: GoogleFonts.inter(
              color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        Image.asset('assets/icons/right-arrow.png', width: 22)
      ],
    );
  }
}
