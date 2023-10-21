import 'package:Uzaar/widgets/get_stars_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Colors.dart';

final userNameTextStyle = GoogleFonts.outfit(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: black,
);

final durationTextStyle = GoogleFonts.outfit(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  color: grey,
);

class ReviewListTile extends StatelessWidget {
  final String imageName;
  final String detail;
  final String date;
  final String title;
  ReviewListTile(
      {required this.imageName,
      required this.title,
      required this.detail,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width,
      // height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imageName),
          SizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: userNameTextStyle,
                    ),
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      style: durationTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                StarsTile(
                  noOfStars: 5,
                  width: 16,
                  height: 16,
                  alignment: MainAxisAlignment.start,
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Text(
                    detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: kTextFieldHintStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
