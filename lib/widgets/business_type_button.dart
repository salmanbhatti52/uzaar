import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/Colors.dart';

final double width = 100.w;
final double height = 40.h;

class BusinessTypeButton extends StatelessWidget {
  final String businessName;
  final Gradient? gradient;
  final Color? buttonBackground;
  final Color textColor;
  // final int catSelected;

  BusinessTypeButton(
      {required this.businessName,
      required this.gradient,
      required this.buttonBackground,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: gradient,
        color: buttonBackground,
      ),
      child: Center(
        child: Text(
          businessName,
          style: kBodyTextStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
