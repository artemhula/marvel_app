import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/left-arrow.png',
              width: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Back',
              style:
                  GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
