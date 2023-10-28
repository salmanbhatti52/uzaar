import 'package:Uzaar/screens/ListingsScreens/housing_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/product_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/service_listing_screen.dart';
import 'package:Uzaar/widgets/business_type_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/utils/colors.dart';

import '../../widgets/product_list_tile.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  int selectedCategory = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = 1;
                    });
                  },
                  child: BusinessTypeButton(
                      businessName: 'Products',
                      gradient: selectedCategory == 1 ? gradient : null,
                      buttonBackground:
                          selectedCategory != 1 ? grey.withOpacity(0.3) : null,
                      textColor: selectedCategory == 1 ? white : grey),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = 2;
                    });
                  },
                  child: BusinessTypeButton(
                      businessName: 'Services',
                      gradient: selectedCategory == 2 ? gradient : null,
                      buttonBackground:
                          selectedCategory != 2 ? grey.withOpacity(0.3) : null,
                      textColor: selectedCategory == 2 ? white : grey),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = 3;
                    });
                  },
                  child: BusinessTypeButton(
                      businessName: 'Housing',
                      gradient: selectedCategory == 3 ? gradient : null,
                      buttonBackground:
                          selectedCategory != 3 ? grey.withOpacity(0.3) : null,
                      textColor: selectedCategory == 3 ? white : grey),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            selectedCategory == 1
                ? ProductListingScreen()
                : selectedCategory == 2
                    ? ServiceListingScreen()
                    : HousingListingScreen(),
            // SizedBox(
            //   height: 10,
            // )
          ],
        ),
      ),
    );
  }
}
