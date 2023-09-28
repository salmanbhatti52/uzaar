import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color black = Color(0xff242222);
const Color primaryBlue = Color(0xff450E8B);
const Color grey = Color(0xff808080);
const Color white = Color(0xffFFFFFF);
const Color green = Color(0xff34A853);

const LinearGradient gradient = LinearGradient(
  colors: [
    Color(0xff450E8B),
    Color(0xffEC8C34),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final kAppBarTitleStyle = GoogleFonts.outfit(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: black,
);

final kSimpleTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: grey,
);

final kColoredTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: primaryBlue,
);

final TextStyle kTextFieldHintStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: grey,
);

final TextStyle kTextFieldInputStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: black,
);

final kRoundedActiveBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: primaryBlue,
    width: 1,
  ),
);

final kRoundedBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: Colors.grey,
    width: 1,
  ),
);

final kRoundedWhiteBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: Colors.white,
    width: 1,
  ),
);

// final kRoundedWhiteActiveBorderStyle = OutlineInputBorder(
//   borderRadius: BorderRadius.circular(40),
//   borderSide: const BorderSide(
//     color: Colors.white,
//     width: 1,
//   ),
// );

final kSearchTextFieldBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  borderRadius: BorderRadius.circular(40),
);
