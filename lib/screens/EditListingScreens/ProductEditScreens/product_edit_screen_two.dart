import 'dart:convert';

import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'package:Uzaar/widgets/rounded_dropdown_menu.dart';
import 'package:http/http.dart';

import '../../../utils/Buttons.dart';
import '../../../utils/colors.dart';
import '../../../widgets/snackbars.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

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
                      Align(
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
                          prefixIcon:
                              SvgIcon(imageName: 'assets/tag_price_bold.svg'),
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
                      Align(
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
                        onSelected: (value) {
                          setState(() {
                            selectedBoosting =
                                '\$${double.parse(value['price'])} ${value['name']}';
                          });
                          print(selectedBoosting);
                          selectedBoostingItem = value;
                          print(selectedBoostingItem);
                        },
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
                                  'condition':
                                      widget.formData['productCondition'],
                                  'name': widget.formData['productName'],
                                  'description':
                                      widget.formData['productDescription'],
                                  'price': widget.formData['productPrice'],
                                  'min_offer_price':
                                      minPriceEditingController.text.toString(),
                                  'packages_id':
                                      selectedBoostingItem?['packages_id'],
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
                            if (status == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SuccessSnackBar());
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BottomNavBar(
                                      requiredScreenIndex: 0,
                                    );
                                  },
                                ),
                                (route) => false,
                              );
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
