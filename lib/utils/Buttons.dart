import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'colors.dart';

Widget primaryButton(
    {context,
    required String buttonText,
    Function()? onTap,
    required bool showLoader}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.sizeOf(context).width,
      height: 54,
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(buttonText, style: kPrimaryButtonTextStyle),
          showLoader
              ? Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const SizedBox()
        ],
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
          const SizedBox(
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
          const SizedBox(
            width: 10.0,
          ),
          SvgPicture.asset('assets/facebook-logo.svg'),
        ],
      ),
    ),
  );
}

Widget outlinedButton(
    {context,
    Function()? onTap,
    required String buttonText,
    required bool showLoader}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // padding: EdgeInsets.symmetric(horizontal: 65.w),
      margin: const EdgeInsets.only(bottom: 20),
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
              buttonText,
              style: kOutlinedButtonTextStyle,
            ),
            showLoader
                ? Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const CircularProgressIndicator(
                      color: primaryBlue,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    ),
  );
}
