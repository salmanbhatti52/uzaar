import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class IconTextReusable extends StatelessWidget {
  const IconTextReusable(
      {super.key,
      required this.imageName,
      required this.text,
      this.style,
      this.width,
      this.height,
      this.spaceBetween,
      required this.mainAxisAlignment});
  final String imageName;
  final String text;
  final TextStyle? style;
  final double? height;
  final double? width;
  final double? spaceBetween;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SvgPicture.asset(
          'assets/$imageName.svg',
          width: width ?? 14,
          height: height ?? 14,
        ),
        SizedBox(
          width: spaceBetween ?? 2.w,
        ),
        Text(
          text,
          style: style ?? kFontEightFiveHG,
        )
      ],
    );
  }
}
