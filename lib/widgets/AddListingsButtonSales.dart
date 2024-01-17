import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uzaar/utils/colors.dart';

Widget addListingsButtonSales(context, Function()? onTap) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 22.w),
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 110.w),
    width: double.infinity,
    height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: primaryBlue, width: 2),
    ),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Listing',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              color: primaryBlue,
              fontSize: 18,
            ),
          ),
          SvgPicture.asset('assets/add-button.svg'),
        ],
      ),
    ),
  );
}
