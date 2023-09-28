import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Colors.dart';

class CommonListTile extends StatelessWidget {
  final String imageName;
  final String detail;
  final String duration;
  final String title;
  CommonListTile(
      {required this.imageName,
      required this.title,
      required this.detail,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(imageName),
              SizedBox(
                width: 10.w,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: grey,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Text(
              duration,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
