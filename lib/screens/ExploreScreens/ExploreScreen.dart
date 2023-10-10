import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/search_field.dart';
import 'ExploreProductsScreen.dart';
import 'ExploreServicesScreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final searchController = TextEditingController();

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catSelected = 1;
  }

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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          catSelected = 1;
                        });
                      },
                      child: BusinessTypeButton(
                        businessName: 'Products',
                        gradient: catSelected == 1 ? gradient : null,
                        buttonBackground:
                            catSelected != 1 ? grey.withOpacity(0.3) : null,
                        textColor: catSelected == 1 ? white : grey,
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
                      child: BusinessTypeButton(
                        businessName: 'Services',
                        gradient: catSelected == 2 ? gradient : null,
                        buttonBackground:
                            catSelected != 2 ? grey.withOpacity(0.3) : null,
                        textColor: catSelected == 2 ? white : grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          catSelected = 3;
                        });
                      },
                      child: BusinessTypeButton(
                        businessName: 'Housing',
                        gradient: catSelected == 3 ? gradient : null,
                        buttonBackground:
                            catSelected != 3 ? grey.withOpacity(0.3) : null,
                        textColor: catSelected == 3 ? white : grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SearchField(searchController: searchController),
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
