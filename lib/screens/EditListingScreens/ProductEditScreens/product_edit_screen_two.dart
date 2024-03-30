import 'dart:convert';

import 'package:uzaar/services/restService.dart';
import 'package:uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzaar/widgets/BottomNaviBar.dart';
import 'package:uzaar/widgets/rounded_dropdown_menu.dart';
import 'package:http/http.dart';

import '../../../utils/Buttons.dart';
import '../../../utils/colors.dart';
import '../../../widgets/snackbars.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';
import '../../BusinessDetailPages/payment_screen.dart';

class ProductEditScreenTwo extends StatefulWidget {
  static const String id = 'product_add_screen_two';
  const ProductEditScreenTwo(
      {super.key, required this.formData, required this.listingData});
  final dynamic listingData;
  final Map<String, dynamic> formData;
  @override
  State<ProductEditScreenTwo> createState() => _ProductEditScreenTwoState();
}

class _ProductEditScreenTwoState extends State<ProductEditScreenTwo> {
  int noOfTabs = 3;
  final minPriceEditingController = TextEditingController();
  String? selectedBoosting;
  dynamic selectedBoostingItem;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
  Map<dynamic, dynamic>? initialBoostingValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.formData);
    print(widget.listingData);
    addDataToFields();
  }

  addDataToFields() {
    minPriceEditingController.text = widget.listingData['min_offer_price'];
    if (widget.listingData['users_customers_packages'] != null) {
      int index = boostingPackagesGV.indexWhere((map) =>
          map['name'] ==
          widget.listingData['users_customers_packages']['packages']['name']);
      initialBoostingValue = boostingPackagesGV[index];
      // updateSelectedBoosting(initialBoostingValue);
    }
  }

  updateSelectedBoosting(value) {
    setState(() {
      selectedBoosting = '\$${double.parse(value['price'])} ${value['name']}';
    });
    print(selectedBoosting);
    selectedBoostingItem = value;
    print(selectedBoostingItem);

    if (sellerMultiListingPackageGV.isNotEmpty &&
        sellerMultiListingPackageGV['payment_status'] == 'Paid' &&
        value['name'] != sellerMultiListingPackageGV['packages']['name']) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
            message:
            'You have the subscription of Monthly Unlimited Boosting package.'));
      });

    }
  }

  boostIndividualListing(
      {required listingsProductsId, required usersCustomersPkgsId}) async {
    setState(() {
      setLoader = true;
      setButtonStatus = 'Please wait..';
    });
    Response response =
        await sendPostRequest(action: 'boost_listings_individually', data: {
      "users_customers_packages_id": usersCustomersPkgsId,
      "listings_products_id": listingsProductsId,
      "listings_services_id": "",
      "listings_housings_id": ""
    });
    setState(() {
      setLoader = false;
      setButtonStatus = 'Save Changes';
    });
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
          SuccessSnackBar(message: 'Your listing boosted successfully'));
    } else if (status == 'error') {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: decodedResponse['message']));
    } else {}
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const BottomNavBar(
            requiredScreenIndex: 0,
          );
        },
      ),
      (route) => false,
    );
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 3 ? null : grey,
        gradient: i == 3 ? gradient : null,
        margin: i == noOfTabs ? null : EdgeInsets.only(right: 10.w),
      );
      tabs.add(tab);
    }
    return tabs;
  }

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
          elevation: 0,
          backgroundColor: Colors.white,
          leading: NavigateBack(buildContext: context),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getPageIndicators(),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Add Minimum Offer Price '),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: minPriceEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon: const SvgIcon(
                              imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Minimum Price',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        '*Boost your listings now to get more  orders or you can boost later',
                        style: kTextFieldInputStyle,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child:
                            ReusableText(text: 'Boosting Options (Optional)'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                        width: MediaQuery.sizeOf(context).width * 0.887,
                        leadingIconName: 'boost_icon',
                        hintText: 'Select Option',
                        onSelected: updateSelectedBoosting,
                        initialSelection: initialBoostingValue,
                        dropdownMenuEntries: boostingPackagesGV
                            .map(
                              (dynamic value) => DropdownMenuEntry<dynamic>(
                                  value: value,
                                  label:
                                      '\$${double.parse(value['price'])} ${value['name']}'),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.34,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                        context: context,
                        buttonText: setButtonStatus,
                        onTap: () async {
                          if (minPriceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz add price you want to offer'));
                          } else {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            setState(() {
                              setLoader = true;
                              setButtonStatus = 'Please wait..';
                            });

                            Response response = await sendPostRequest(
                                action: 'edit_listings_products',
                                data: {
                                  'listings_products_id': widget
                                      .listingData['listings_products_id'],
                                  'listings_categories_id':
                                      widget.formData['categoryId'],
                                  'listings_sub_categories_id':
                                      widget.formData['productSubCategoryId'],
                                  'condition':
                                      widget.formData['productCondition'],
                                  'name': widget.formData['productName'],
                                  'description':
                                      widget.formData['productDescription'],
                                  'price': widget.formData['productPrice'],
                                  'min_offer_price':
                                      minPriceEditingController.text.toString(),
                                  'packages_id':
                                      sellerMultiListingPackageGV.isNotEmpty &&
                                              sellerMultiListingPackageGV[
                                                      'payment_status'] ==
                                                  'Paid' &&
                                              selectedBoostingItem?[
                                                      'packages_id'] !=
                                                  sellerMultiListingPackageGV[
                                                      'packages']['packages_id']
                                          ? ""
                                          : sellerMultiListingPackageGV
                                                      .isNotEmpty &&
                                                  selectedBoostingItem?[
                                                          'packages_id'] ==
                                                      sellerMultiListingPackageGV[
                                                              'packages']
                                                          ['packages_id']
                                              ? ""
                                              : selectedBoostingItem?[
                                                  'packages_id'],
                                  'listings_images':
                                      widget.formData['imagesList'],
                                });

                            setState(() {
                              setLoader = false;
                              setButtonStatus = 'Save Changes';
                            });

                            print(response.statusCode);
                            print(response.body);
                            var decodedResponse = jsonDecode(response.body);
                            String status = decodedResponse['status'];
                            Map data = decodedResponse['data'];
                            if (status == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SuccessSnackBar());
                              if (data['featured'] == 'No') {
                                if (selectedBoostingItem?['packages_id'] !=
                                    null) {
                                  // ================inner if-else starting below==================
                                  //============ start case: selecting any boost listing package
                                  if (sellerMultiListingPackageGV.isEmpty) {
                                    print(
                                        'multi-listing pkg not subscribed, and chosen a different package');
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => PaymentScreen(
                                                  buyTheProduct: false,
                                                  buyTheBoosting: true,
                                                  listingProductId: data[
                                                      'listings_products_id'],
                                                  selectedPackage: data[
                                                          'users_customers_packages']
                                                      ['packages'],
                                                  userCustomerPackagesId: data[
                                                          'users_customers_packages']
                                                      [
                                                      'users_customers_packages_id'],
                                                )),
                                        (route) => false);
                                  }
                                  //============ cases: for selecting a different package other than multi-listing

                                  else if (sellerMultiListingPackageGV
                                          .isNotEmpty &&
                                      sellerMultiListingPackageGV[
                                              'payment_status'] ==
                                          'Unpaid' &&
                                      selectedBoostingItem?[
                                              'packages_id'] !=
                                          sellerMultiListingPackageGV[
                                              'packages']['packages_id']) {
                                    print(
                                        'multi-listing already subscribed, not bought, and chosen a different package');
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => PaymentScreen(
                                                  buyTheProduct: false,
                                                  buyTheBoosting: true,
                                                  listingProductId: data[
                                                      'listings_products_id'],
                                                  selectedPackage: data[
                                                          'users_customers_packages']
                                                      ['packages'],
                                                  userCustomerPackagesId: data[
                                                          'users_customers_packages']
                                                      [
                                                      'users_customers_packages_id'],
                                                )),
                                        (route) => false);
                                  } else if (sellerMultiListingPackageGV
                                          .isNotEmpty &&
                                      sellerMultiListingPackageGV[
                                              'payment_status'] ==
                                          'Paid' &&
                                      selectedBoostingItem?['packages_id'] !=
                                          sellerMultiListingPackageGV[
                                              'packages']['packages_id']) {
                                    print(
                                        'multi-listing already subscribed and bought, and chosen a different package');

                                    await boostIndividualListing(
                                        listingsProductsId:
                                            data['listings_products_id'],
                                        usersCustomersPkgsId:
                                            sellerMultiListingPackageGV[
                                                'users_customers_packages_id']);
                                  }
                                  //============ cases done: for selecting a different package other than multi-listing
                                  //============ cases: for selecting a multi-listing package
                                  else if (sellerMultiListingPackageGV
                                          .isNotEmpty &&
                                      selectedBoostingItem?['packages_id'] ==
                                          sellerMultiListingPackageGV[
                                              'packages']['packages_id'] &&
                                      sellerMultiListingPackageGV[
                                              'payment_status'] ==
                                          'Unpaid') {
                                    print(
                                        'multi-listing already subscribed, not bought but again choose multi-listing package');
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => PaymentScreen(
                                                  buyTheProduct: false,
                                                  buyTheBoosting: true,
                                                  listingProductId: data[
                                                      'listings_products_id'],
                                                  selectedPackage:
                                                      sellerMultiListingPackageGV[
                                                          'packages'],
                                                  userCustomerPackagesId:
                                                      sellerMultiListingPackageGV[
                                                          'users_customers_packages_id'],
                                                )),
                                        (route) => false);
                                  } else if (sellerMultiListingPackageGV
                                          .isNotEmpty &&
                                      selectedBoostingItem?['packages_id'] ==
                                          sellerMultiListingPackageGV[
                                              'packages']['packages_id'] &&
                                      sellerMultiListingPackageGV[
                                              'payment_status'] ==
                                          'Paid') {
                                    print(
                                        'multi-listing already subscribed and bought but again chosen multi-listing package');
                                    await boostIndividualListing(
                                        listingsProductsId:
                                            data['listings_products_id'],
                                        usersCustomersPkgsId:
                                            sellerMultiListingPackageGV[
                                                'users_customers_packages_id']);
                                  }
                                  // ================inner if-else done==================
                                } else if (selectedBoostingItem?[
                                        'packages_id'] ==
                                    null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const BottomNavBar(
                                          requiredScreenIndex: 0,
                                        );
                                      },
                                    ),
                                    (route) => false,
                                  );
                                } else {}
                              } else if (data['featured'] == 'Yes') {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const BottomNavBar(
                                        requiredScreenIndex: 0,
                                      );
                                    },
                                  ),
                                  (route) => false,
                                );
                              } else {}
                            }
                            if (status == 'error') {
                              String message = decodedResponse?['message'];
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        message,
                                        style: kToastTextStyle,
                                      )));
                            }
                          }
                        },
                        showLoader: setLoader),
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
