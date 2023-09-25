import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';

import 'AddProductImageScreen.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  int pageSelected = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageSelected = 1;
    catSelected = 1;
  }

  int catSelected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 180.w,
                height: 45.h,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      // padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 45.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: pageSelected == 1 ? null : grey,
                        gradient: pageSelected == 1 ? gradient : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 45.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: pageSelected == 2 ? null : grey,
                        gradient: pageSelected == 2 ? gradient : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: 45.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: pageSelected == 3 ? null : grey,
                        gradient: pageSelected == 3 ? gradient : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'What do you want to sell?',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelected = 1;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: catSelected == 1 ? gradient : null,
                      color: catSelected == 2 ? grey.withOpacity(0.3) : null,
                    ),
                    child: Center(
                      child: Text(
                        'Products',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: catSelected == 2 ? grey : white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelected = 2;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: catSelected == 2 ? gradient : null,
                      color: catSelected == 1 ? grey.withOpacity(0.3) : null,
                    ),
                    child: Center(
                      child: Text(
                        'Services',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: catSelected == 2 ? white : grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            catSelected == 1
                ? Expanded(
                    child: AddProductImageScreen(
                    pageSelected: pageSelected,
                  ))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
