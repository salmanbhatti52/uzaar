import 'dart:convert';

import 'package:Uzaar/screens/ListingsScreens/housing_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/product_listing_screen.dart';
import 'package:Uzaar/screens/ListingsScreens/service_listing_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/business_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/DrawerWidget.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  int selectedCategory = 1;
  List<dynamic> boostingPackages = [...boostingPackagesGV];
  bool showSpinner = false;

  int _tapCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    getBoostingPackages();
  }

  getBoostingPackages() async {
    Response response = await sendGetRequest('get_packages');

    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    boostingPackagesGV = [];
    if (status == 'success') {
      boostingPackagesGV = decodedData['data'];
      if (mounted) {
        setState(() {
          boostingPackages = boostingPackagesGV;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _tapCount++;
        print(_tapCount);
        if (_tapCount == 1) {
        } else if (_tapCount >= 2) {
          // Pop the navigator after the second tap
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70,
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SvgPicture.asset(
                  'assets/drawer-button.svg',
                  fit: BoxFit.scaleDown,
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: [
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
        body: ModalProgressHUD(
          color: Colors.white,
          inAsyncCall: showSpinner,
          child: Padding(
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
                          buttonBackground: selectedCategory != 1
                              ? grey.withOpacity(0.3)
                              : null,
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
                          buttonBackground: selectedCategory != 2
                              ? grey.withOpacity(0.3)
                              : null,
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
                          buttonBackground: selectedCategory != 3
                              ? grey.withOpacity(0.3)
                              : null,
                          textColor: selectedCategory == 3 ? white : grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                selectedCategory == 1 && boostingPackages.isNotEmpty
                    ? ProductListingScreen(
                        // listedProductsErrMsg: listedProductsErrMsg,
                        selectedCategory: selectedCategory,
                        boostingPackages: boostingPackages,
                        // listedProducts: listedProducts,
                      )
                    : selectedCategory == 2 && boostingPackages.isNotEmpty
                        ? ServiceListingScreen(
                            selectedCategory: selectedCategory,
                            boostingPackages: boostingPackages,
                          )
                        : selectedCategory == 3 && boostingPackages.isNotEmpty
                            ? HousingListingScreen(
                                selectedCategory: selectedCategory,
                                boostingPackages: boostingPackages,
                              )
                            : Expanded(
                                child: Shimmer.fromColors(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 80,
                                          margin: EdgeInsets.only(
                                              top: 2,
                                              left: 5,
                                              right: 5,
                                              bottom: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                        );
                                      },
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                    ),
                                    baseColor: Colors.grey[500]!,
                                    highlightColor: Colors.grey[100]!),
                              ),
                // SizedBox(
                //   height: 10,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
