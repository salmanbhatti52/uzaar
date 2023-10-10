import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';

import '../utils/Colors.dart';

Widget readOnlyContainer(String objectIcon, String objectText) {
  return Container(
    padding: EdgeInsets.only(left: 13),
    width: double.infinity,
    height: 50.h,
    decoration: kContainerBoxDecoration,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgIcon(imageName: objectIcon),
        SizedBox(
          width: 10.w,
        ),
        Text(
          objectText,
          style: kTextFieldInputStyle,
        ),
      ],
    ),
  );
}