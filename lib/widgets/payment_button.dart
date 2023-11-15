import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

Widget paymentWidget(
    {required String image,
    required String text,
    Decoration? decoration,
    EdgeInsetsGeometry? margin,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      width: 146,
      height: 54,
      decoration: decoration,
      child: Row(
        children: [
          Image.asset(
            image,
            // fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: kFontEighteenSixHB,
          )
        ],
      ),
    ),
  );
}
