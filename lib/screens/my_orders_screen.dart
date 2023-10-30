import 'package:Uzaar/screens/MyOrderScreens/OfferTabScreens/offered_housings_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/OfferTabScreens/offered_products_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/OfferTabScreens/offered_services_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PendingTabScreens/pending_Housings_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PendingTabScreens/pending_products_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PendingTabScreens/pending_services_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PreviousTabScreens/previous_housings_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PreviousTabScreens/previous_products_of_my_orders.dart';
import 'package:Uzaar/screens/MyOrderScreens/PreviousTabScreens/previous_services_of_my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';
import '../widgets/business_type_button.dart';
import '../widgets/mini_dropdown_menu.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedCategory = 2;
  String selectedBusiness = 'Products';
  final List<String> businessTypes = ['Products', 'Services', 'Housing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/back-arrow-button.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: false,
        title: Text(
          'My Orders',
          style: kAppBarTitleStyle,
        ),
      ),
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
                      businessName: 'Offers',
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
                      businessName: 'Pending',
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
                      businessName: 'Previous',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedBusiness,
                  style: kBodyHeadingTextStyle,
                ),
                RoundedMiniDropdownMenu(
                    width: 120,
                    onSelected: (value) {
                      setState(() {
                        selectedBusiness = value;
                      });
                    },
                    initialSelection: selectedBusiness,
                    dropdownMenuEntries: businessTypes
                        .map(
                          (String value) => DropdownMenuEntry<String>(
                              value: value, label: value),
                        )
                        .toList(),
                    // hintText: 'Products',
                    leadingIconName: null),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (selectedCategory == 1 && selectedBusiness == 'Products')
              OfferedProductsOfMyOrders()
            else if (selectedCategory == 1 && selectedBusiness == 'Services')
              OfferedServicesOfMyOrders()
            else if (selectedCategory == 1 && selectedBusiness == 'Housing')
              OfferedHousingsOfMyOrders()
            else if (selectedCategory == 2 && selectedBusiness == 'Products')
              PendingProductsOfMyOrders()
            else if (selectedCategory == 2 && selectedBusiness == 'Services')
              PendingServicesOfMyOrders()
            else if (selectedCategory == 2 && selectedBusiness == 'Housing')
              PendingHousingsOfMyOrders()
            else if (selectedCategory == 3 && selectedBusiness == 'Products')
              PreviousProductsOfMyOrders()
            else if (selectedCategory == 3 && selectedBusiness == 'Services')
              PreviousServicesOfMyOrders()
            else if (selectedCategory == 3 && selectedBusiness == 'Housing')
              PreviousHousingsOfMyOrders()
            else
              SizedBox(
                height: 10,
              )
          ],
        ),
      ),
    );
  }
}
