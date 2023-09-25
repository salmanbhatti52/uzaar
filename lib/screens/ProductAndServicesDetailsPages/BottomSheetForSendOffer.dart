import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';


class BottomSheetForSendOffer extends StatefulWidget {
  const BottomSheetForSendOffer({super.key});

  @override
  State<BottomSheetForSendOffer> createState() =>
      _BottomSheetForSendOfferState();
}

class _BottomSheetForSendOfferState extends State<BottomSheetForSendOffer> {
  int selectedOffer = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedOffer = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
      height: 230.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Offer',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOffer = 1;
                  });
                },
                child: Row(
                  children: [
                    selectedOffer == 1
                        ? SvgPicture.asset('assets/selected.svg')
                        : SvgPicture.asset('assets/unselected.svg'),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '\$${'200'}',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOffer = 2;
                  });
                },
                child: Row(
                  children: [
                    selectedOffer == 2
                        ? SvgPicture.asset('assets/selected.svg')
                        : SvgPicture.asset('assets/unselected.svg'),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '\$${'200'}',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOffer = 3;
              });
            },
            child: Row(
              children: [
                selectedOffer == 3
                    ? SvgPicture.asset('assets/selected.svg')
                    : SvgPicture.asset('assets/unselected.svg'),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  '\$${'200'}',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: null,
            child: primaryButton(context, 'Send Offer'),
          ),
        ],
      ),
    );
  }
}
