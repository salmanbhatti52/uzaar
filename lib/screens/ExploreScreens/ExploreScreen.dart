import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'ExploreProductsScreen.dart';
import 'ExploreServicesScreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late TextEditingController searchController;

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchController = TextEditingController();
    catSelected = 1;
  }

  // final TextStyle hintStyle = GoogleFonts.outfit(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w300,
  //   color: grey,
  // );
  //
  // final TextStyle inputStyle = GoogleFonts.outfit(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w300,
  //   color: black,
  // );

  // final InputBorder outlineBorder = OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: grey,
  //       width: 1,
  //     ),
  //     borderRadius: BorderRadius.circular(40));
  //
  // final InputBorder focusBorder = OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: primaryBlue,
  //       width: 1,
  //     ),
  //     borderRadius: BorderRadius.circular(40));
  //
  // final InputBorder enableBorder = OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: primaryBlue,
  //       width: 1,
  //     ),
  //     borderRadius: BorderRadius.circular(40));

  int catSelected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
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
                            color:
                                catSelected == 2 ? grey.withOpacity(0.3) : null,
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
                            color:
                                catSelected == 1 ? grey.withOpacity(0.3) : null,
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: kTextFieldBoxDecoration,
                  // width: double.infinity,
                  // height: 50.h,
                  child: TextFormFieldWidget(
                    controller: searchController,
                    textInputType: TextInputType.name,
                    enterTextStyle: kTextFieldInputStyle,
                    cursorColor: primaryBlue,
                    prefixIcon: SvgPicture.asset(
                      'assets/search-button.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: 'Search Here',
                    border: kRoundedWhiteBorderStyle,
                    hintStyle: kTextFieldInputStyle,
                    focusedBorder: kRoundedActiveBorderStyle,
                    obscureText: null,
                    enableBorder: kRoundedWhiteBorderStyle,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                catSelected == 2
                    ? ExploreServicesScreen()
                    : ExploreProductsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
