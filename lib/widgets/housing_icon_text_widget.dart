import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Colors.dart';

final kLittleLabelTexStyle = GoogleFonts.outfit(
  fontSize: 8,
  fontWeight: FontWeight.w500,
  color: grey,
);

class HousingIconTextWidget extends StatelessWidget {
  const HousingIconTextWidget(
      {super.key, required this.imageName, required this.text});
  final String imageName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/$imageName.svg',
          width: 14,
          height: 14,
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          text,
          style: kLittleLabelTexStyle,
        )
      ],
    );
  }
}
