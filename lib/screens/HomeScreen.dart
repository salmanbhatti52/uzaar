import 'package:Uzaar/widgets/featured_housing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/models/HousingCategoryModel.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';
import 'package:Uzaar/models/ProductCategoryModel.dart';
import 'package:Uzaar/models/ServicesCategoryModel.dart';
import 'package:Uzaar/widgets/search_field.dart';

import '../widgets/business_type_button.dart';
import 'ProductAndServicesDetailsPages/ProductDetailsPage.dart';
import 'ProductAndServicesDetailsPages/ServiceDetailsPage.dart';

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
    return Scaffold(
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
                  height: 100.h,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 205.h,
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
                ),

                Text(
                  'Featured Services',
                  style: kBodyHeadingTextStyle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 204.h,
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
                ),
                Text(
                  'Featured Housing',
                  style: kBodyHeadingTextStyle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 215.h,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsPage(),
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
                ),
              ],
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
      // color: primaryBlue,
      child: SizedBox(
        width: 80.w,
        // height: 98.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 70.h,
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
