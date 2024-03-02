import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kActiveButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.red),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
);

final kDefaultButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.black),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
  ),
);

final kLargeTextStyle = GoogleFonts.inter(
  fontSize: 25,
  fontWeight: FontWeight.w800,
);

final kMediumTextStyle = GoogleFonts.inter(
  fontSize: 22,
  fontWeight: FontWeight.w700,
);

final kSmallTextStyle = GoogleFonts.inter(
  color: Colors.grey,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
