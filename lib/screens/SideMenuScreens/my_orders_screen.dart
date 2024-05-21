import 'dart:convert';

import 'package:uzaar/screens/MyOrderScreens/OfferTabScreens/offered_products_of_my_orders.dart';
import 'package:uzaar/screens/MyOrderScreens/PendingTabScreens/pending_products_of_my_orders.dart';
import 'package:uzaar/screens/MyOrderScreens/PreviousTabScreens/previous_products_of_my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../services/restService.dart';
import '../../utils/Colors.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/mini_dropdown_menu.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedCategory = 2;
  String selectedBusiness = 'Products';
  List<String> businessTypes = ['Products'];
  String orderedProductOffersErrMsg = '';
  List<dynamic> myOrderedProductOffers = [];

  getMyProductOrdersOffers() async {
    Response response = await sendPostRequest(
        action: 'get_listings_orders_offers',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          myOrderedProductOffers = decodedData['data'];
          for (dynamic offer in myOrderedProductOffers) {
            DateTime dateTime = DateTime.parse(offer['date_added']);
            offer['date_added'] = DateFormat('dd/MM/yyyy').format(dateTime);
            if (offer['status'] != 'Pending') {
              DateTime dateTime = DateTime.parse(offer['date_modified']);
              offer['date_modified'] =
                  DateFormat('dd/MM/yyyy').format(dateTime);
            }
          }
        });
      }
    }
    if (status == 'error') {
      if (mounted) {
        setState(() {
          orderedProductOffersErrMsg = decodedData['message'];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProductOrdersOffers();
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                      businessTypes = ['Products'];
                      selectedBusiness = 'Products';
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
                      businessTypes = ['Products'];
                      selectedBusiness = 'Products';
                    });
                  },
                  child: BusinessTypeButton(
                      // businessName: 'Pending',
                      businessName: 'In Progress',
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
                      businessTypes = ['Products'];
                      selectedBusiness = 'Products';
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
            const SizedBox(
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
                    enabled: true,
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
            const SizedBox(
              height: 20,
            ),
            if (selectedCategory == 1 && selectedBusiness == 'Products')
              OfferedProductsOfMyOrders(
                myOrderedProductOffers: myOrderedProductOffers,
                orderedProductOffersErrMsg: orderedProductOffersErrMsg,
              )
            // else if (selectedCategory == 1 && selectedBusiness == 'Services')
            //   const OfferedServicesOfMyOrders()
            // else if (selectedCategory == 1 && selectedBusiness == 'Housing')
            //   const OfferedHousingsOfMyOrders()
            else if (selectedCategory == 2 && selectedBusiness == 'Products')
              const PendingProductsOfMyOrders()
            // else if (selectedCategory == 2 && selectedBusiness == 'Services')
            //   const PendingServicesOfMyOrders()
            // else if (selectedCategory == 2 && selectedBusiness == 'Housing')
            //   const PendingHousingsOfMyOrders()
            else if (selectedCategory == 3 && selectedBusiness == 'Products')
              const PreviousProductsOfMyOrders()
            // else if (selectedCategory == 3 && selectedBusiness == 'Services')
            //   const PreviousServicesOfMyOrders()
            // else if (selectedCategory == 3 && selectedBusiness == 'Housing')
            //   const PreviousHousingsOfMyOrders()
            else
              const SizedBox(
                height: 10,
              )
          ],
        ),
      ),
    );
  }
}
