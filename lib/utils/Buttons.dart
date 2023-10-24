import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Colors.dart';

Widget primaryButton(context, String buttonText, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // margin:  EdgeInsets.only(
      //     bottom: 25),
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(buttonText, style: kPrimaryButtonTextStyle),
      ),
    ),
  );
}

/// Google button

Widget googleButton(context) {
  return Container(
    // padding: EdgeInsets.symmetric(horizontal: 65.w),
    width: double.infinity,
    height: 54,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login with Google',
            style: kOutlinedButtonTextStyle,
          ),
          SizedBox(
            width: 10.0,
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
    // padding: EdgeInsets.symmetric(horizontal: 65.w),
    width: double.infinity,
    height: 54,
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
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login with Facebook',
            style: kOutlinedButtonTextStyle,
          ),
          SizedBox(
            width: 10.0,
          ),
          SvgPicture.asset('assets/facebook-logo.svg'),
        ],
      ),
    ),
  );
}

Widget outlinedButton(context, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // padding: EdgeInsets.symmetric(horizontal: 65.w),
      width: double.infinity,
      height: 54,
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
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Continue as Guest',
              style: kOutlinedButtonTextStyle,
            ),
          ],
        ),
      ),
    ),
  );
}
