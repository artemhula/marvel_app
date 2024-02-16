import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.function,
  });
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Row(
      children: [
        Image.asset(
          'assets/icons/search.png',
          height: 22,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              cursorColor: Colors.red,
              cursorWidth: 2,
              style:
                  GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search here',
                hintStyle: GoogleFonts.inter(fontSize: 18),
              ),
              onChanged: (value) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                debounce = Timer(const Duration(milliseconds: 700), () {
                  function(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
