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

final kPrimaryButtonTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: white,
);

final kOutlinedButtonTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: primaryBlue,
);

final kBodyHeadingTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: black,
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

final kBodyTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: black,
);

final kColoredBodyTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);

final kColoredTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: primaryBlue,
);

final TextStyle kTextFieldHintStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: grey,
);

final TextStyle kTextFieldInputStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
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

final kTextFieldBoxDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  borderRadius: BorderRadius.circular(40),
);

final kOtpActiveBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: primaryBlue,
    width: 1,
  ),
);

final kOtpWhiteBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.white,
    width: 1,
  ),
);

final kOtpBoxDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  borderRadius: BorderRadius.circular(10),
);

final kContainerBoxDecoration = BoxDecoration(
  color: white,
  borderRadius: BorderRadius.circular(40),
  border: Border.all(color: white, width: 1),
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
);

final kOptInputDecoration = InputDecoration(
  // constraints:
  //     BoxConstraints(minHeight: 70, minWidth: 50, maxHeight: 70, maxWidth: 50),
  filled: true,
  fillColor: Colors.white,
  counterText: '',
  hintText: '0',
  hintStyle: kTextFieldHintStyle,
  border: kOtpWhiteBorderStyle,
  enabledBorder: kOtpWhiteBorderStyle,
  focusedBorder: kOtpActiveBorderStyle,
  // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
);
