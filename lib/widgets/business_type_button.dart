import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

final double height = 38;

class BusinessTypeButton extends StatelessWidget {
  final String businessName;
  final Gradient? gradient;
  final Color? buttonBackground;
  final Color textColor;
  double? width;
  EdgeInsetsGeometry? margin;
  // final int catSelected;

  BusinessTypeButton(
      {required this.businessName,
      required this.gradient,
      required this.buttonBackground,
      required this.textColor,
      this.width,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? 94,
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
