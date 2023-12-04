import 'package:flutter/material.dart';

import '../utils/colors.dart';

const double height = 38;

class BusinessTypeButton extends StatelessWidget {
  final String businessName;
  final Gradient? gradient;
  final Color? buttonBackground;
  final Color textColor;
  final double? width;
  final EdgeInsetsGeometry? margin;
  // final int catSelected;

  const BusinessTypeButton(
      {super.key,
      required this.businessName,
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
