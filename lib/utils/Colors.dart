import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color black = Color(0xff242222);
const Color primaryBlue = Color(0xff450E8B);
const Color grey = Color(0xff808080);
const Color white = Color(0xffFFFFFF);
const Color green = Color(0xff34A853);
const Color f7f8f8 = Color(0xffF7F8F8);
const Color lightGreen = Color(0xff00D796);
const Color yellow = Color(0xffFEBC5A);
const Color red = Color(0xffFB4B40);
const Color f5f5f5 = Color(0xffF5F5F5);

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

final kBodySubHeadingTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: black,
);

final kFontEighteenSixHB = GoogleFonts.outfit(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: black,
);

final kBodyHeadingTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w600,
  fontSize: 20,
  color: black,
);

final kToastTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

final kBodyPrimaryBoldTextStyle = GoogleFonts.outfit(
  fontWeight: FontWeight.w600,
  fontSize: 20,
  color: primaryBlue,
);

final kAppBarTitleStyle = GoogleFonts.outfit(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: black,
);

final kFontEightFiveHG = GoogleFonts.outfit(
  fontSize: 8,
  fontWeight: FontWeight.w500,
  color: grey,
);

final kFontEightFiveHPB = GoogleFonts.outfit(
  fontSize: 8,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
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
  textStyle: TextStyle(overflow: TextOverflow.ellipsis),
);

final kColoredTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: primaryBlue,
);

final kFontTenFiveHG = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  color: grey,
);

final kFontTwelveFourHG = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: grey,
);

final kFontTwelveFourHW = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: white,
);

final kFontTwelveSixHPB = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: primaryBlue,
);

final kFontTwelveSixHW = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: white,
);

final kFontFourteenFiveHG = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: grey,
);
final kFontSixteenSixHPB = GoogleFonts.outfit(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: primaryBlue,
);
final kFontSixteenSixHB = GoogleFonts.outfit(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: black,
);

final kUploadImageBoxBorderShadow = ShapeDecoration(
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadows: const [
    BoxShadow(
      color: Color(0x23000000),
      blurRadius: 4,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ],
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

final TextStyle kFontFourteenFourHW = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: white,
);

final kFontFourteenSixHPB = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: primaryBlue,
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
    color: white,
    width: 1,
  ),
);

final kTextAreaRoundedWhiteBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: const BorderSide(
    color: Colors.white,
    width: 1,
  ),
);
final kTextAreaRoundedActiveBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: const BorderSide(
    color: primaryBlue,
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
  color: Colors.white,
  borderRadius: BorderRadius.circular(40),
);

final kTextAreaBoxDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
);

// final k

const kCardBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: white,
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

final kCardBoxBorder = BoxDecoration(
  border: Border.all(
    color: primaryBlue,
    width: 2,
  ),
  borderRadius: BorderRadius.circular(10),
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
