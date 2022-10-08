import 'package:flutter/material.dart';

// package | google_fonts
import 'package:google_fonts/google_fonts.dart';

final TextStyle stylesPageHeaderHeading = GoogleFonts.poppins(
  fontSize: 27,
  fontWeight: FontWeight.w600,
);
final TextStyle stylesPageHeaderDescription = GoogleFonts.poppins(
  fontSize: 17,
  color: Colors.black54
  // fontWeight: FontWeight.w600,
);

final TextStyle stylesPageHeaderNumber = GoogleFonts.poppins(
  fontSize: 15,
  color: Colors.black,
  // fontWeight: FontWeight.w600,
);
final TextStyle stylesPageLink = GoogleFonts.poppins(
  fontSize: 14,
  color: Colors.blueAccent,
  fontWeight: FontWeight.w600,
);

// form
final TextStyle stylesInput = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w600
);
final TextStyle stylesInputError = GoogleFonts.poppins(
  fontSize: 13
);
final ButtonStyle stylesSubmitBtn = ElevatedButton.styleFrom(
  textStyle: GoogleFonts.poppins(
    fontSize: 16
  ),
  padding: const EdgeInsets.symmetric(vertical: 11),
  elevation: 0,
  backgroundColor: Colors.black,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);