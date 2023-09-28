import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/models/HousingCategoryModel.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'package:sellpad/widgets/FeaturedProductsWidget.dart';
import 'package:sellpad/widgets/FeaturedServicesWidget.dart';
import 'package:sellpad/models/ProductCategoryModel.dart';
import 'package:sellpad/models/ServicesCategoryModel.dart';

import 'ProductAndServicesDetailsPages/ProductDetailsPage.dart';
import 'ProductAndServicesDetailsPages/ServiceDetailsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchController = TextEditingController();
    catSelected = 1;
  }

  int catSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  // width: double.infinity,
                  // height: 50.h,
                  // elevation: 5,
                  decoration: kSearchTextFieldBoxDecoration,
                  child: TextFormFieldWidget(
                    controller: searchController,
                    textInputType: TextInputType.name,
                    enterTextStyle: kTextFieldInputStyle,
                    cursorColor: primaryBlue,
                    prefixIcon: SvgPicture.asset(
                      'assets/search-button.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: 'Search Here',
                    border: kRoundedWhiteBorderStyle,
                    hintStyle: kTextFieldHintStyle,
                    focusedBorder: kRoundedActiveBorderStyle,
                    obscureText: null,
                    enableBorder: kRoundedWhiteBorderStyle,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'What are you looking for?',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          catSelected = 1;
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: catSelected == 1 ? gradient : null,
                          color:
                              catSelected != 1 ? grey.withOpacity(0.3) : null,
                        ),
                        child: Center(
                          child: Text(
                            'Products',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: catSelected == 1 ? white : grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          catSelected = 2;
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: catSelected == 2 ? gradient : null,
                          color:
                              catSelected != 2 ? grey.withOpacity(0.3) : null,
                        ),
                        child: Center(
                          child: Text(
                            'Services',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: catSelected == 2 ? white : grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          catSelected = 3;
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: catSelected == 3 ? gradient : null,
                          color:
                              catSelected != 3 ? grey.withOpacity(0.3) : null,
                        ),
                        child: Center(
                          child: Text(
                            'Housing',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: catSelected == 3 ? white : grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(),
                SizedBox(
                  height: 100.h,
                  child: catSelected == 1
                      ? ListView.builder(
                          itemCount: productCategoryModel.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 7),
                              // color: primaryBlue,
                              child: SizedBox(
                                width: 75.w,
                                // height: 98.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 70.h,
                                      child: SvgPicture.asset(
                                        productCategoryModel[index].image,
                                      ),
                                    ),
                                    Text(
                                      productCategoryModel[index].catName,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : catSelected == 2
                          ? ListView.builder(
                              itemCount: servicesCategoryModel.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 7),
                                  // color: primaryBlue,
                                  child: SizedBox(
                                    width: 75.w,
                                    // height: 98.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 70.h,
                                          child: SvgPicture.asset(
                                            servicesCategoryModel[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          servicesCategoryModel[index]
                                              .serviceName,
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: housingCategoryModel.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 7),
                                  // color: primaryBlue,
                                  child: SizedBox(
                                    width: 75.w,
                                    // height: 98.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 70.h,
                                          child: SvgPicture.asset(
                                            housingCategoryModel[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          housingCategoryModel[index].houseName,
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Featured Products',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 200.h,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(),
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return FeaturedProductsWidget(
                          image: 'assets/product-ph.png',
                          productCategory: 'Electronics',
                          productDescription: 'Iphone 14',
                          productLocation: 'Los Angeles',
                          productPrice: '120',
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                  child: Text(
                    'Featured Services',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 200.h,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                  child: Text(
                    'Featured Housing',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 200.h,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsPage(),
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedServicesWidget(
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
