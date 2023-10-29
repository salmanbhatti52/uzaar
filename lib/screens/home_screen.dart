import 'package:Uzaar/screens/BusinessDetailPages/housing_details_page.dart';
import 'package:Uzaar/widgets/featured_housing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/models/HousingCategoryModel.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';
import 'package:Uzaar/models/ProductCategoryModel.dart';
import 'package:Uzaar/models/ServicesCategoryModel.dart';
import 'package:Uzaar/widgets/search_field.dart';

import '../widgets/DrawerWidget.dart';
import '../widgets/business_type_button.dart';
import 'BusinessDetailPages/product_details_page.dart';
import 'BusinessDetailPages/service_details_page.dart';
import 'chat_list_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedCategory = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            'Home',
            style: kAppBarTitleStyle,
          ),
        ),
        drawer: DrawerWidget(
          buildContext: context,
        ),
        backgroundColor: Colors.white,
        body: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: primaryBlue,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'John',
                  //         style: GoogleFonts.outfit(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           color: black,
                  //         ),
                  //       )
                  //     ],
                  //     text: 'Good Morning!   ',
                  //     style: GoogleFonts.outfit(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //       color: black,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SearchField(searchController: searchController),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'What are you looking for?',
                    style: kBodySubHeadingTextStyle,
                  ),
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
                    height: 30.h,
                  ),

                  SizedBox(
                    height: 98,
                    child: selectedCategory == 1
                        ? ListView.builder(
                            itemCount: productCategoryModel.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return BusinessListTile(
                                businessTileImageName:
                                    productCategoryModel[index].image,
                                businessTileName:
                                    productCategoryModel[index].catName,
                              );
                            },
                          )
                        : selectedCategory == 2
                            ? ListView.builder(
                                itemCount: servicesCategoryModel.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return BusinessListTile(
                                      businessTileName:
                                          servicesCategoryModel[index]
                                              .serviceName,
                                      businessTileImageName:
                                          servicesCategoryModel[index].image);
                                },
                              )
                            : ListView.builder(
                                itemCount: housingCategoryModel.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return BusinessListTile(
                                      businessTileName:
                                          housingCategoryModel[index].houseName,
                                      businessTileImageName:
                                          housingCategoryModel[index].image);
                                },
                              ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Featured Products',
                    style: kBodyHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 187,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(),
                            ),
                          ),
                          child: FeaturedProductsWidget(
                            image: 'assets/product-ph.png',
                            productCategory: 'Electronics',
                            productDescription: 'Iphone 14',
                            productLocation: 'Los Angeles',
                            productPrice: '120',
                          ),
                        );
                      },
                      itemCount: 6,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Featured Services',
                    style: kBodyHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 187,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsPage(),
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedServicesWidget(
                            image: 'assets/service-ph.png',
                            productCategory: 'Designing',
                            productDescription: 'Graphic Design',
                            productLocation: 'Los Angeles',
                            productPrice: '20',
                          );
                        },
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Featured Housing',
                    style: kBodyHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 202,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HousingDetailsPage(),
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedHousingWidget(
                            image: 'assets/housing-ph.png',
                            productCategory: 'Rental',
                            productDescription: '2 Bedroom house',
                            productLocation: 'Los Angeles',
                            productPrice: '20',
                          );
                        },
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BusinessListTile extends StatelessWidget {
  const BusinessListTile({
    required this.businessTileName,
    required this.businessTileImageName,
    super.key,
  });
  final String businessTileName;
  final String businessTileImageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      child: SizedBox(
        width: 74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 70,
              child: SvgPicture.asset(
                businessTileImageName,
              ),
            ),
            Center(
              child: Text(
                businessTileName,
                style: kBodyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
