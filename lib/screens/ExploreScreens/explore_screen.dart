import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/ExploreScreens/explore_housing_screen.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/search_field.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';
import 'explore_products_screen.dart';
import 'explore_services_screen.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key, this.requiredListingIndex});
  int? requiredListingIndex;
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // final searchController = TextEditingController();
  int _tapCount = 0;
  int selectedListingType = 1;
  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    print('widget.requiredListingIndex: ${widget.requiredListingIndex}');
    setState(() {
      if (widget.requiredListingIndex != null) {
        selectedListingType = widget.requiredListingIndex!;
      }
      widget.requiredListingIndex = null;
    });
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
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
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
              'Explore',
              style: kAppBarTitleStyle,
            ),
          ),
          drawer: DrawerWidget(
            buildContext: context,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: listingTypesGV != null
                            ? List.generate(
                                listingTypesGV?['data'].length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedListingType =
                                          listingTypesGV?['data'][index]
                                              ['listings_types_id'];
                                    });
                                    print(
                                        'selectedListingType: $selectedListingType');
                                  },
                                  child: BusinessTypeButton(
                                      margin: index <
                                              listingTypesGV?['data'].length - 1
                                          ? EdgeInsets.only(right: 10)
                                          : null,
                                      businessName: listingTypesGV?['data']
                                          [index]['name'],
                                      gradient: selectedListingType ==
                                              listingTypesGV?['data'][index]
                                                  ['listings_types_id']
                                          ? gradient
                                          : null,
                                      buttonBackground: selectedListingType !=
                                              listingTypesGV?['data'][index]
                                                  ['listings_types_id']
                                          ? grey.withOpacity(0.3)
                                          : null,
                                      textColor: selectedListingType ==
                                              listingTypesGV?['data'][index]
                                                  ['listings_types_id']
                                          ? white
                                          : grey),
                                ),
                              )
                            : List.generate(
                                3,
                                (index) => Shimmer.fromColors(
                                    child: BusinessTypeButton(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        businessName: '',
                                        gradient: null,
                                        buttonBackground: grey.withOpacity(0.3),
                                        textColor: grey),
                                    baseColor: Colors.grey[500]!,
                                    highlightColor: Colors.grey[100]!),
                              ),
                      ),
                    ],
                  ),
                ),
                selectedListingType == 1
                    ? ExploreProductsScreen()
                    : selectedListingType == 2
                        ? ExploreServicesScreen()
                        : ExploreHousingScreen()
                // : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
