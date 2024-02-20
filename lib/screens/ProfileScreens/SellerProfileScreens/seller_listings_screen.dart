import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uzaar/services/restService.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/featured_services_widget.dart';

import 'package:uzaar/widgets/featured_products_widget.dart';

import '../../../utils/Buttons.dart';
import '../../../widgets/alert_dialog_reusable.dart';
import '../../../widgets/featured_housing_widget.dart';
import '../../BusinessDetailPages/housing_details_page.dart';
import '../../BusinessDetailPages/product_details_page.dart';
import '../../BusinessDetailPages/service_details_page.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class SellerListingsScreen extends StatefulWidget {
  SellerListingsScreen({super.key, this.sellerData});
  dynamic sellerData;
  @override
  State<SellerListingsScreen> createState() => _SellerListingsScreenState();
}

class _SellerListingsScreenState extends State<SellerListingsScreen> {
  List<dynamic> userFeaturedProducts = [];
  List<dynamic> userFeaturedServices = [];
  List<dynamic> userFeaturedHousings = [];
  String userFeaturedProductsErrMsg = '';
  String userFeaturedServicesErrMsg = '';
  String userFeaturedHousingsErrMsg = '';

  getFeaturedListings() {
    List filteredFeaturedProducts = [];
    List filteredFeaturedServices = [];
    List filteredFeaturedHousings = [];

    // Filtering User Featured Products
    for (dynamic product in featuredProductsGV) {
      if (product['users_customers_id'] ==
          widget.sellerData['users_customers_id']) {
        filteredFeaturedProducts.add(product);
      }
    }

    // Filtering User Featured Services
    for (dynamic service in featuredServicesGV) {
      if (service['users_customers_id'] ==
          widget.sellerData['users_customers_id']) {
        filteredFeaturedServices.add(service);
      }
    }

    // Filtering User Featured Housings
    for (dynamic house in featuredHousingGV) {
      if (house['users_customers_id'] ==
          widget.sellerData['users_customers_id']) {
        filteredFeaturedHousings.add(house);
      }
    }

    if (mounted) {
      setState(() {
        // saving user featured products and setting error message
        userFeaturedProducts = filteredFeaturedProducts;
        if (userFeaturedProducts.isEmpty) {
          userFeaturedProductsErrMsg = 'No listing found.';
        }
        // saving user featured services and setting error message
        userFeaturedServices = filteredFeaturedServices;
        if (userFeaturedServices.isEmpty) {
          userFeaturedServicesErrMsg = 'No listing found.';
        }
        // saving user featured housings and setting error message
        userFeaturedHousings = filteredFeaturedHousings;
        if (userFeaturedHousings.isEmpty) {
          userFeaturedHousingsErrMsg = 'No listing found.';
        }
      });
    }
    print('userFeaturedProducts: $userFeaturedProducts');
    print('userFeaturedServices: $userFeaturedServices');
    print('userFeaturedHousings: $userFeaturedHousings');
  }

  late Set<ReportReason> selectedReasons = {};
  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeaturedListings();
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Featured Products',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 180,
                child: userFeaturedProducts.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedProductsWidget(
                            productCondition: userFeaturedProducts[index]
                                ['condition'],
                            image: imgBaseUrl +
                                userFeaturedProducts[index]['listings_images']
                                    [0]['image'],
                            productCategory: userFeaturedProducts[index]
                                ['listings_categories']['name'],
                            productName: userFeaturedProducts[index]['name'],
                            // productLocation: 'California',
                            productPrice: userFeaturedProducts[index]['price'],
                            onImageTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    productData: userFeaturedProducts[index],
                                  ),
                                ),
                              );
                            },
                            onOptionTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter stateSetterObject) {
                                    return AlertDialogReusable(
                                      description:
                                          'Select any reason to report. We will show you less listings like this next time.',
                                      title: 'Report Listing',
                                      itemsList: [
                                        SizedBox(
                                          height: 35,
                                          child: ListTile(
                                            title: Text(
                                              'Not Interested',
                                              style: kTextFieldInputStyle,
                                            ),
                                            leading: GestureDetector(
                                              onTap: () {
                                                stateSetterObject(() {
                                                  handleOptionSelection(
                                                      ReportReason
                                                          .notInterested);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .notInterested)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          child: ListTile(
                                            title: Text(
                                              'Not Authentic',
                                              style: kTextFieldInputStyle,
                                            ),
                                            leading: GestureDetector(
                                              onTap: () {
                                                stateSetterObject(() {
                                                  handleOptionSelection(
                                                      ReportReason
                                                          .notAuthentic);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .notAuthentic)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          child: ListTile(
                                            title: Text(
                                              'Inappropriate',
                                              style: kTextFieldInputStyle,
                                            ),
                                            leading: GestureDetector(
                                              onTap: () {
                                                stateSetterObject(() {
                                                  handleOptionSelection(
                                                      ReportReason
                                                          .inappropriate);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .inappropriate)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          child: ListTile(
                                            title: Text(
                                              'Violent or prohibited content',
                                              style: kTextFieldInputStyle,
                                            ),
                                            leading: GestureDetector(
                                              onTap: () {
                                                stateSetterObject(() {
                                                  handleOptionSelection(
                                                      ReportReason.violent);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(
                                                          ReportReason.violent)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          child: ListTile(
                                            title: Text(
                                              'Other',
                                              style: kTextFieldInputStyle,
                                            ),
                                            leading: GestureDetector(
                                              onTap: () {
                                                stateSetterObject(() {
                                                  handleOptionSelection(
                                                      ReportReason.other);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(
                                                          ReportReason.other)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                      ],
                                      button: primaryButton(
                                          context: context,
                                          buttonText: 'Send',
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          showLoader: false),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        itemCount: userFeaturedProducts.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                      )
                    : userFeaturedProducts.isEmpty &&
                            userFeaturedProductsErrMsg.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return const FeaturedProductsDummy();
                              },
                              itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                            ))
                        : Center(
                            child: Text(userFeaturedProductsErrMsg),
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
                child: userFeaturedServices.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedServicesWidget(
                            image: imgBaseUrl +
                                userFeaturedServices[index]['listings_images']
                                    [0]['image'],
                            serviceCategory: userFeaturedServices[index]
                                ['listings_categories']['name'],
                            serviceName: userFeaturedServices[index]['name'],
                            serviceLocation: userFeaturedServices[index]
                                ['location'],
                            servicePrice: userFeaturedServices[index]['price'],
                            onImageTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ServiceDetailsPage(
                                  serviceData: userFeaturedServices[index],
                                ),
                              ),
                            ),
                            onOptionTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter stateSetterObject) {
                                    return AlertDialogReusable(
                                        description:
                                            'Select any reason to report. We will show you less listings like this next time.',
                                        title: 'Report Listing',
                                        itemsList: [
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Not Interested',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .notInterested);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .notInterested)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Not Authentic',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .notAuthentic);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .notAuthentic)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Inappropriate',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .inappropriate);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .inappropriate)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Violent or prohibited content',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason.violent);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .violent)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Other',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason.other);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(
                                                            ReportReason.other)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                        ],
                                        button: primaryButton(
                                            context: context,
                                            buttonText: 'Send',
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                            showLoader: false));
                                  },
                                ),
                              );
                            },
                          );
                        },
                        itemCount: userFeaturedServices.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                      )
                    : userFeaturedServices.isEmpty &&
                            userFeaturedServicesErrMsg.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return const FeaturedProductsDummy();
                              },
                              itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                            ))
                        : Center(
                            child: Text(userFeaturedServicesErrMsg),
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
                height: 206,
                child: userFeaturedHousings.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return FeaturedHousingWidget(
                            furnishedStatus: userFeaturedHousings[index]
                                        ['furnished'] ==
                                    'Yes'
                                ? 'Furnished'
                                : 'Not Furnished',
                            image: imgBaseUrl +
                                userFeaturedHousings[index]['listings_images']
                                    [0]['image'],
                            housingCategory: userFeaturedHousings[index]
                                ['listings_categories']['name'],
                            housingName: userFeaturedHousings[index]['name'],
                            housingLocation: userFeaturedHousings[index]
                                ['location'],
                            housingPrice: userFeaturedHousings[index]['price'],
                            area: userFeaturedHousings[index]['area'],
                            bedrooms: userFeaturedHousings[index]['bedroom'],
                            bathrooms: userFeaturedHousings[index]['bathroom'],
                            onImageTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HousingDetailsPage(
                                  houseData: userFeaturedHousings[index],
                                ),
                              ));
                            },
                            onOptionTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter stateSetterObject) {
                                    return AlertDialogReusable(
                                        description:
                                            'Select any reason to report. We will show you less listings like this next time.',
                                        title: 'Report Listing',
                                        itemsList: [
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Not Interested',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .notInterested);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .notInterested)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Not Authentic',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .notAuthentic);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .notAuthentic)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Inappropriate',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason
                                                            .inappropriate);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .inappropriate)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Violent or prohibited content',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason.violent);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
                                                            .violent)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              title: Text(
                                                'Other',
                                                style: kTextFieldInputStyle,
                                              ),
                                              leading: GestureDetector(
                                                onTap: () {
                                                  stateSetterObject(() {
                                                    handleOptionSelection(
                                                        ReportReason.other);
                                                  });
                                                },
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(
                                                            ReportReason.other)
                                                    ? 'assets/selected_check.svg'
                                                    : 'assets/default_check.svg'),
                                              ),
                                            ),
                                          ),
                                        ],
                                        button: primaryButton(
                                            context: context,
                                            buttonText: 'Send',
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                            showLoader: false));
                                  },
                                ),
                              );
                            },
                          );
                        },
                        itemCount: userFeaturedHousings.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                      )
                    : userFeaturedHousings.isEmpty &&
                            userFeaturedHousingsErrMsg.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return const FeaturedProductsDummy();
                              },
                              itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                            ))
                        : Center(
                            child: Text(userFeaturedHousingsErrMsg),
                          ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
