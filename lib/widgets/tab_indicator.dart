import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../utils/colors.dart';
// int noOfTabs = 3;

class TabIndicator extends StatelessWidget {
  const TabIndicator(
      {super.key,
      required this.color,
      required this.gradient,
      required this.margin});

  final Color? color;
  final Gradient? gradient;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      // padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: 45.w,
      height: 15.h,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
