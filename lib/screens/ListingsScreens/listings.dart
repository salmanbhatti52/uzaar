import 'package:Uzaar/screens/ListingsScreens/housing_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/product_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/service_listing_screen.dart';
import 'package:Uzaar/widgets/business_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/utils/colors.dart';

import '../../widgets/DrawerWidget.dart';
import '../../widgets/product_list_tile.dart';
import '../messages_screen.dart';
import '../notifications_screen.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SvgPicture.asset(
                  'assets/drawer-button.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Row(
              children: [
                // Column(
                //   children: [
                //     Text(
                //       'Good Morning!',
                //       style: kAppBarTitleStyle,
                //     ),
                //     Text(
                //       'John',
                //       style: kAppBarTitleStyle,
                //     ),
                //   ],
                // ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessagesScreen(),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/msg-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/notification-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ],
        centerTitle: false,
        title: Text(
          'Listing',
          style: kAppBarTitleStyle,
        ),
      ),
      drawer: DrawerWidget(
        buildContext: context,
      ),
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
                ? ProductListingScreen(
                    selectedCategory: selectedCategory,
                  )
                : selectedCategory == 2
                    ? ServiceListingScreen(
                        selectedCategory: selectedCategory,
                      )
                    : HousingListingScreen(
                        selectedCategory: selectedCategory,
                      ),
            // SizedBox(
            //   height: 10,
            // )
          ],
        ),
      ),
    );
  }
}
