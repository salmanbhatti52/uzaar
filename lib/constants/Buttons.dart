import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget primaryButton(context, String buttonText) {
  return Container(
    width: double.infinity,
    height: 55.h,
    decoration: BoxDecoration(
      color: primaryBlue,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Text(
        buttonText,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: white,
        ),
      ),
    ),
  );
}

/// Google button

Widget googleButton(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 65.w),
    width: double.infinity,
    height: 55.h,
    decoration: BoxDecoration(
      color: white,
      border: Border.all(
        color: primaryBlue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Signup with Google',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: black,
            ),
          ),
          SvgPicture.asset('assets/google-logo.svg'),
        ],
      ),
    ),
  );
}

/// facebook button

Widget facebookButton(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 65.w),
    width: double.infinity,
    height: 55.h,
    decoration: BoxDecoration(
      color: white,
      border: Border.all(
        color: primaryBlue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Signup with Facebook',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: black,
            ),
          ),
          SvgPicture.asset('assets/facebook-logo.svg'),
        ],
      ),
    ),
  );
}
