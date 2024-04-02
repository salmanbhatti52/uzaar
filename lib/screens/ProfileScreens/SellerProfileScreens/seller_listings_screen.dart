import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uzaar/services/restService.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/featured_services_widget.dart';

import 'package:uzaar/widgets/featured_products_widget.dart';

import '../../../utils/Buttons.dart';
import '../../../widgets/alert_dialog_reusable.dart';
import '../../../widgets/featured_housing_widget.dart';
import '../../../widgets/snackbars.dart';
import '../../BusinessDetailPages/housing_details_page.dart';
import '../../BusinessDetailPages/product_details_page.dart';
import '../../BusinessDetailPages/service_details_page.dart';



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

  late String selectedReason = '';
  late int selectedReasonId;
  String setSendReportButtonStatus = 'Send';
  bool setSendReportButtonLoader = false;

  Future<String> reportListing({required int listingId, required int listingTypeId, required int listingCategoriesId, required int listingReportReasonId,}) async{
    Response response = await sendPostRequest(action: 'add_listings_reports', data: {
      "listings_id": listingId,
      "listings_types_id": listingTypeId,
      "listings_categories_id": listingCategoriesId,
      "users_customers_id": userDataGV['userId'],
      "listings_reports_reasons_id": listingReportReasonId
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if(status == 'success'){
      return status;
    }else if(status == 'error'){
      return decodedResponse['message'];
    }else{
      return '';
    }
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
                            sellerProfileVerified: userFeaturedProducts[index]
                                ['users_customers']['badge_verified'],
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
                              if(userDataGV['userId'] == userFeaturedProducts[index]['users_customers_id']){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(
                                        message: 'You can only see your profile details'));
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter stateSetterObject) {
                                      return AlertDialogReusable(
                                        description:
                                        'Select any reason to report. We will show you less listings like this next time.',
                                        title: 'Report Listing',
                                        itemsList:List.generate(
                                          listingsReportReasonsGV
                                              .length,
                                              (index) =>
                                              SizedBox(
                                                height: 35,
                                                child: ListTile(
                                                  title: Text(
                                                    listingsReportReasonsGV[
                                                    index]
                                                    ['reason'],
                                                    style:
                                                    kTextFieldInputStyle,
                                                  ),
                                                  leading:
                                                  GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(
                                                              () {
                                                            selectedReason =
                                                            listingsReportReasonsGV[index]
                                                            [
                                                            'reason'];
                                                            selectedReasonId = listingsReportReasonsGV[index]['listings_reports_reasons_id'];
                                                          });
                                                    },
                                                    child: SvgPicture.asset(selectedReason ==
                                                        listingsReportReasonsGV[index]
                                                        [
                                                        'reason']
                                                        ? 'assets/selected_check.svg'
                                                        : 'assets/default_check.svg'),
                                                  ),
                                                ),
                                              ),
                                        ),
                                        button: primaryButton(
                                            context: context,
                                            buttonText: setSendReportButtonStatus,
                                            onTap: () async {
                                              stateSetterObject((){
                                                setSendReportButtonStatus = 'Please wait..';
                                                setSendReportButtonLoader = true;
                                              });
                                              String apiResponse = await reportListing(
                                                  listingId: userFeaturedProducts[index]['listings_products_id'],
                                                  listingTypeId: userFeaturedProducts[index]['listings_types_id'],
                                                  listingCategoriesId: userFeaturedProducts[index]['listings_categories_id'],
                                                  listingReportReasonId: selectedReasonId
                                              );

                                              stateSetterObject((){

                                                setSendReportButtonStatus = 'Send';
                                                setSendReportButtonLoader = false;
                                              });
                                              if(apiResponse == 'success'){

                                                ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Listing Reported'));

                                              }else if(apiResponse.isNotEmpty && apiResponse != 'success'){

                                                ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: apiResponse));

                                              }
                                              Navigator.of(
                                                  context)
                                                  .pop();
                                            },
                                            showLoader: setSendReportButtonLoader),
                                      );
                                    },
                                  ),
                                );
                              }

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
                            sellerProfileVerified: userFeaturedServices[index]
                                ['users_customers']['badge_verified'],
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
                              if(userDataGV['userId'] == userFeaturedServices[index]['users_customers_id']){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(
                                        message: 'You can only see your profile details'));
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter stateSetterObject) {
                                      return AlertDialogReusable(
                                          description:
                                          'Select any reason to report. We will show you less listings like this next time.',
                                          title: 'Report Listing',
                                          itemsList:List.generate(
                                            listingsReportReasonsGV
                                                .length,
                                                (index) =>
                                                SizedBox(
                                                  height: 35,
                                                  child: ListTile(
                                                    title: Text(
                                                      listingsReportReasonsGV[
                                                      index]
                                                      [
                                                      'reason'],
                                                      style:
                                                      kTextFieldInputStyle,
                                                    ),
                                                    leading:
                                                    GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(
                                                                () {
                                                              selectedReason =
                                                              listingsReportReasonsGV[index]
                                                              [
                                                              'reason'];
                                                              selectedReasonId = listingsReportReasonsGV[index]['listings_reports_reasons_id'];
                                                            });
                                                      },
                                                      child: SvgPicture.asset(selectedReason ==
                                                          listingsReportReasonsGV[index]
                                                          [
                                                          'reason']
                                                          ? 'assets/selected_check.svg'
                                                          : 'assets/default_check.svg'),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                          button:  primaryButton(
                                              context: context,
                                              buttonText: setSendReportButtonStatus,
                                              onTap: () async {
                                                stateSetterObject((){
                                                  setSendReportButtonStatus = 'Please wait..';
                                                  setSendReportButtonLoader = true;
                                                });
                                                String apiResponse = await reportListing(
                                                    listingId: userFeaturedServices[index]['listings_services_id'],
                                                    listingTypeId: userFeaturedServices[index]['listings_types_id'],
                                                    listingCategoriesId: userFeaturedServices[index]['listings_categories_id'],
                                                    listingReportReasonId: selectedReasonId
                                                );

                                                stateSetterObject((){

                                                  setSendReportButtonStatus = 'Send';
                                                  setSendReportButtonLoader = false;
                                                });
                                                if(apiResponse == 'success'){

                                                  ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Listing Reported'));

                                                }else if(apiResponse.isNotEmpty && apiResponse != 'success'){

                                                  ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: apiResponse));

                                                }
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                              showLoader: setSendReportButtonLoader));
                                    },
                                  ),
                                );
                              }

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
                            sellerProfileVerified: userFeaturedHousings[index]
                                ['users_customers']['badge_verified'],
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
                              if(userDataGV['userId'] == userFeaturedHousings[index]['users_customers_id']){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(
                                        message: 'You can only see your profile details'));
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter stateSetterObject) {
                                      return AlertDialogReusable(
                                          description:
                                          'Select any reason to report. We will show you less listings like this next time.',
                                          title: 'Report Listing',
                                          itemsList:List.generate(
                                            listingsReportReasonsGV
                                                .length,
                                                (index) =>
                                                SizedBox(
                                                  height: 35,
                                                  child: ListTile(
                                                    title: Text(
                                                      listingsReportReasonsGV[
                                                      index]
                                                      [
                                                      'reason'],
                                                      style:
                                                      kTextFieldInputStyle,
                                                    ),
                                                    leading:
                                                    GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(
                                                                () {
                                                              selectedReason =
                                                              listingsReportReasonsGV[index]
                                                              [
                                                              'reason'];
                                                              selectedReasonId = listingsReportReasonsGV[index]['listings_reports_reasons_id'];
                                                            });
                                                      },
                                                      child: SvgPicture.asset(selectedReason ==
                                                          listingsReportReasonsGV[index]
                                                          [
                                                          'reason']
                                                          ? 'assets/selected_check.svg'
                                                          : 'assets/default_check.svg'),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                          button: primaryButton(
                                              context: context,
                                              buttonText: setSendReportButtonStatus,
                                              onTap: () async {
                                                stateSetterObject((){
                                                  setSendReportButtonStatus = 'Please wait..';
                                                  setSendReportButtonLoader = true;
                                                });
                                                String apiResponse = await reportListing(
                                                    listingId: userFeaturedHousings[index]['listings_housings_id'],
                                                    listingTypeId: userFeaturedHousings[index]['listings_types_id'],
                                                    listingCategoriesId: userFeaturedHousings[index]['listings_categories_id'],
                                                    listingReportReasonId: selectedReasonId
                                                );

                                                stateSetterObject((){

                                                  setSendReportButtonStatus = 'Send';
                                                  setSendReportButtonLoader = false;
                                                });
                                                if(apiResponse == 'success'){

                                                  ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Listing Reported'));

                                                }else if(apiResponse.isNotEmpty && apiResponse != 'success'){

                                                  ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: apiResponse));

                                                }
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                              showLoader: setSendReportButtonLoader));
                                    },
                                  ),
                                );
                              }

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
