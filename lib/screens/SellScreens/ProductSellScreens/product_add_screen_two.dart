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

class ProductAddScreenTwo extends StatefulWidget {
  static const String id = 'product_add_screen_two';
  const ProductAddScreenTwo(
      {super.key, this.editDetails, required this.formData});
  final bool? editDetails;
  final Map<String, dynamic> formData;
  @override
  State<ProductAddScreenTwo> createState() => _ProductAddScreenTwoState();
}

class _ProductAddScreenTwoState extends State<ProductAddScreenTwo> {
  int noOfTabs = 3;
  final minPriceEditingController = TextEditingController();
  late String? selectedBoostingOption = '';
  List<String> boostingOptions = ['Free', 'Paid'];
  bool setLoader = false;
  String setButtonStatus = 'Publish';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.formData);
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
                            selectedBoostingOption = value;
                          });
                        },
                        dropdownMenuEntries: boostingOptions
                            .map(
                              (String value) => DropdownMenuEntry<String>(
                                  value: value, label: value),
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
                        buttonText: widget.editDetails == true
                            ? 'Save Changes'
                            : 'Publish',
                        onTap: () async {
                          if (minPriceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz add price you want to offer'));
                          } else {
                            Response response = await sendPostRequest(
                                action: 'add_listings_products',
                                data: {
                                  'users_customers_id':
                                      userDataGV['userId'].toString(),
                                  'listings_types_id': "1",
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
                                  'packages_id': "",
                                  'payment_gateways_id': "",
                                  'payment_status': "",
                                  'listings_images': [
                                    {'image': widget.formData['image']}
                                  ],
                                });

                            print(response.statusCode);
                            print(response.body);

                            return Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return BottomNavBar();
                              },
                            ), (Route<dynamic> route) => false);
                          }
                        },
                        showLoader: false),
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
