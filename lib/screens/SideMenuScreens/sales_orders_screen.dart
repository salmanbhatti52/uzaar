import 'dart:convert';

import 'package:uzaar/screens/SalesOrderScreens/OfferTabScreens/offered_products_of_sales_orders.dart';
import 'package:uzaar/screens/SalesOrderScreens/PendingTabScreens/pending_products_of_sales_orders.dart';
import 'package:uzaar/screens/SalesOrderScreens/PreviousTabScreens/previous_products_of_sales_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../services/restService.dart';
import '../../utils/Colors.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/mini_dropdown_menu.dart';

class SalesOrdersScreen extends StatefulWidget {
  const SalesOrdersScreen({super.key});

  @override
  State<SalesOrdersScreen> createState() => _SalesOrdersScreenState();
}

class _SalesOrdersScreenState extends State<SalesOrdersScreen> {
  int selectedCategory = 2;
  String selectedBusiness = 'Products';
  List<String> businessTypes = ['Products'];
  String salesProductOffersErrMsg = '';
  List<dynamic> salesOrderedProductOffers = [];

  getMyProductSalesOrdersOffers() async {
    Response response = await sendPostRequest(
        action: 'get_sales_listings_orders_offers',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          salesOrderedProductOffers = decodedData['data'];
          for (dynamic offer in salesOrderedProductOffers) {
            DateTime dateTime = DateTime.parse(offer['date_added']);
            offer['date_added'] = DateFormat('dd/MM/yyyy').format(dateTime);
          }
        });
      }
    }
    if (status == 'error') {
      if (mounted) {
        setState(() {
          salesProductOffersErrMsg = decodedData['message'];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProductSalesOrdersOffers();
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
          'Orders',
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
              OfferedProductsOfSalesOrders(
                  salesOrderedProductOffers: salesOrderedProductOffers,
                  salesProductOffersErrMsg: salesProductOffersErrMsg)
            // else if (selectedCategory == 1 && selectedBusiness == 'Services')
            //   const OfferedServicesOfSalesOrders()
            // else if (selectedCategory == 1 && selectedBusiness == 'Housing')
            //   const OfferedHousingsOfSalesOrders()
            else if (selectedCategory == 2 && selectedBusiness == 'Products')
              const PendingProductsOfSalesOrders()
            // else if (selectedCategory == 2 && selectedBusiness == 'Services')
            //   const PendingServicesOfSalesOrders()
            // else if (selectedCategory == 2 && selectedBusiness == 'Housing')
            //   const PendingHousingsOfSalesOrders()
            else if (selectedCategory == 3 && selectedBusiness == 'Products')
              const PreviousProductsOfSalesOrders()
            // else if (selectedCategory == 3 && selectedBusiness == 'Services')
            //   const PreviousServicesOfSalesOrders()
            // else if (selectedCategory == 3 && selectedBusiness == 'Housing')
            //   const PreviousHousingsOfSalesOrders()
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
