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

import 'package:shimmer/shimmer.dart';

import '../../widgets/DrawerWidget.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  int _tapCount = 0;
  int selectedListingType = 1;
  List<dynamic> boostingPackages = [...boostingPackagesGV];

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
          iconTheme: const IconThemeData(color: black),
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
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MessagesScreen(),
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
                        builder: (context) => const NotificationScreen(),
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
                children: listingTypesGV.isNotEmpty
                    ? List.generate(
                        listingTypesGV.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedListingType =
                                  listingTypesGV[index]['listings_types_id'];
                            });
                            print('selectedListingType: $selectedListingType');
                          },
                          child: BusinessTypeButton(
                              margin: index < listingTypesGV.length - 1
                                  ? const EdgeInsets.only(right: 10)
                                  : null,
                              businessName: listingTypesGV[index]['name'],
                              gradient: selectedListingType ==
                                      listingTypesGV[index]['listings_types_id']
                                  ? gradient
                                  : null,
                              buttonBackground: selectedListingType !=
                                      listingTypesGV[index]['listings_types_id']
                                  ? grey.withOpacity(0.3)
                                  : null,
                              textColor: selectedListingType ==
                                      listingTypesGV[index]['listings_types_id']
                                  ? white
                                  : grey),
                        ),
                      )
                    : List.generate(
                        3,
                        (index) => Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[100]!,
                            child: BusinessTypeButton(
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                businessName: '',
                                gradient: null,
                                buttonBackground: grey.withOpacity(0.3),
                                textColor: grey)),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              selectedListingType == 1 && boostingPackages.isNotEmpty
                  ? ProductListingScreen(
                      selectedListingType: selectedListingType,
                      boostingPackages: boostingPackages,
                    )
                  : selectedListingType == 2 && boostingPackages.isNotEmpty
                      ? ServiceListingScreen(
                          selectedListingType: selectedListingType,
                          boostingPackages: boostingPackages,
                        )
                      : selectedListingType == 3 && boostingPackages.isNotEmpty
                          ? HousingListingScreen(
                              selectedListingType: selectedListingType,
                              boostingPackages: boostingPackages,
                            )
                          : Expanded(
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey[500]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 80,
                                        margin: const EdgeInsets.only(
                                            top: 2,
                                            left: 5,
                                            right: 5,
                                            bottom: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      );
                                    },
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                  )),
                            ),
              // SizedBox(
              //   height: 10,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
