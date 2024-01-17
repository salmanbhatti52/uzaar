import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzaar/widgets/suffix_svg_icon.dart';

import '../utils/colors.dart';

Widget readOnlyContainer(String objectIcon, String objectText) {
  return Container(
    padding: const EdgeInsets.only(left: 13),
    width: double.infinity,
    height: 46,
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
