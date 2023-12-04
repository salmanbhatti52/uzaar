import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

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

class SettingsListTile extends StatelessWidget {
  final String detail;
  // final String duration;
  final String title;
  final void Function(bool)? onChanged;
  final bool toggleValue;
  SettingsListTile(
      {required this.title,
      required this.detail,
      required this.onChanged,
      required this.toggleValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width,
      // height: 80.h,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: grey.withOpacity(0.5),
      //   ),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      decoration: kCardBoxDecoration,
      child: Row(
        children: [
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
                    SizedBox(
                      height: 22,
                      width: 40,
                      child: Switch(
                        // trackColor: MaterialStatePropertyAll(primaryBlue),
                        thumbColor: MaterialStatePropertyAll(white),
                        inactiveTrackColor: Color(0xffD9D9D9),
                        activeTrackColor: primaryBlue,

                        activeColor: primaryBlue,
                        value: toggleValue,
                        onChanged: onChanged,
                      ),
                    ),
                    // Text(
                    //   duration,
                    //   textAlign: TextAlign.center,
                    //   style: durationTextStyle,
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // width: MediaQuery.sizeOf(context).width * 0.5,
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
