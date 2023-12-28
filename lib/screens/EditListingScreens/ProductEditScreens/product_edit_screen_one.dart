import 'dart:convert';

import 'package:Uzaar/screens/EditListingScreens/ProductEditScreens/product_edit_screen_two.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:Uzaar/widgets/snackbars.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';

import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

enum ProductConditions { fresh, used }

class ProductEditScreenOne extends StatefulWidget {
  static const String id = 'product_add_screen_one';
  const ProductEditScreenOne(
      {super.key, required this.imagesList, required this.listingData});
  final dynamic listingData;
  final List<Map<String, dynamic>> imagesList;

  @override
  State<ProductEditScreenOne> createState() => _ProductEditScreenOneState();
}

class _ProductEditScreenOneState extends State<ProductEditScreenOne> {
  int noOfTabs = 3;

  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  late Map<String, dynamic> formData;

  late String? selectedCategoryName = '';
  late int selectedCategoryId;
  late int? selectedSubCategoryId;
  String? selectedSubCategory;
  List subCategories = [];
  Map? initialCategoryValue;
  ProductConditions _selectedProductCondition = ProductConditions.fresh;

  updateSelectedCondition(value) {
    _selectedProductCondition = value;
    print(_selectedProductCondition);
  }

  updateSelectedSubCategory(value) {
    setState(() {
      selectedSubCategory = value;
      print(selectedSubCategory);
    });
  }

  getCategorySubCategories({required int categoryId}) async {
    subCategories = [];
    selectedSubCategory = null;
    selectedSubCategoryId = null;
    Response response = await sendPostRequest(
        action: 'get_listings_sub_categories',
        data: {'listings_categories_id': categoryId});
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];

    if (mounted) {
      setState(() {
        if (status == 'success') {
          subCategories = decodedResponse['data'];
          if (widget.listingData['listings_sub_categories'] != null) {
            print('entered');
            selectedSubCategory =
                widget.listingData?['listings_sub_categories']['name'];
            selectedSubCategoryId =
                widget.listingData?['listings_sub_categories']
                    ['listings_sub_categories_id'];
          } else {
            print('not entered');
            selectedSubCategory = subCategories[0]['name'];
            selectedSubCategoryId =
                subCategories[0]['listings_sub_categories_id'];
          }
        }
      });
    }
    print(subCategories);
  }

  updateSelectedCategory(value) {
    selectedCategoryName = value['name'];
    selectedCategoryId = value['listings_categories_id'];
    getCategorySubCategories(categoryId: selectedCategoryId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedCategoryName = productCategories.first;
    print('listing_Data_Product: ${widget.listingData}');
    addDataToFields();
  }

  addDataToFields() {
    nameEditingController.text = widget.listingData['name'];
    descriptionEditingController.text = widget.listingData['description'];
    priceEditingController.text = widget.listingData['price'];
    _selectedProductCondition = widget.listingData['condition'] == 'New'
        ? ProductConditions.fresh
        : ProductConditions.used;

    int index = productListingCategoriesGV.indexWhere((map) =>
        map['name'] == widget.listingData['listings_categories']['name']);
    initialCategoryValue = productListingCategoriesGV[index];
    updateSelectedCategory(initialCategoryValue);
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 2 ? null : grey,
        gradient: i == 2 ? gradient : null,
        margin: i == noOfTabs ? null : const EdgeInsets.only(right: 10),
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: ReusableText(text: 'Product Name'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: nameEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              const SvgIcon(imageName: 'assets/product_icon.svg'),
                          hintText: 'Product Name',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Category'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.887,
                          leadingIconName: 'category_icon',
                          hintText: 'Category',
                          onSelected: updateSelectedCategory,
                          initialSelection: initialCategoryValue,
                          dropdownMenuEntries: productListingCategoriesGV
                              .map(
                                (dynamic value) => DropdownMenuEntry<dynamic>(
                                    value: value, label: value['name']),
                              )
                              .toList()),
                      subCategories.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 14.h,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Seller Type'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    children: List.generate(
                                        subCategories.length, (index) {
                                      return Row(
                                        children: [
                                          Radio(
                                            activeColor: primaryBlue,
                                            fillColor: const MaterialStatePropertyAll(
                                                primaryBlue),
                                            value: subCategories[index]['name'],
                                            groupValue: selectedSubCategory,
                                            onChanged: (value) {
                                              updateSelectedSubCategory(value);
                                              selectedSubCategoryId =
                                                  subCategories[index][
                                                      'listings_sub_categories_id'];
                                              print(selectedSubCategoryId);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            subCategories[index]['name'],
                                            style: kTextFieldInputStyle,
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Condition'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor:
                                      const MaterialStatePropertyAll(primaryBlue),
                                  value: ProductConditions.fresh,
                                  groupValue: _selectedProductCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'New',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor:
                                      const MaterialStatePropertyAll(primaryBlue),
                                  value: ProductConditions.used,
                                  groupValue: _selectedProductCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Used',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Product Description'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: descriptionEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              const SvgIcon(imageName: 'assets/description_icon.svg'),
                          hintText: 'Description here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Price'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: priceEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              const SvgIcon(imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Price',
                          obscureText: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                        context: context,
                        buttonText: 'Next',
                        onTap: () {
                          if (nameEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your product name'));
                          } else if (selectedCategoryName == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz select your product category'));
                          } else if (descriptionEditingController
                              .text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz enter your product description'));
                          } else if (priceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your product price'));
                          } else {
                            formData = {
                              'productName':
                                  nameEditingController.text.toString(),
                              'productCategory': selectedCategoryName,
                              'categoryId': selectedCategoryId,
                              'productSubCategoryId':
                                  selectedSubCategoryId ?? '',
                              'productCondition': _selectedProductCondition ==
                                      ProductConditions.fresh
                                  ? 'New'
                                  : 'Used',
                              'productDescription':
                                  descriptionEditingController.text.toString(),
                              'productPrice':
                                  priceEditingController.text.toString(),
                              'imagesList': widget.imagesList,
                            };

                            print('formData: $formData');

                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductEditScreenTwo(
                                    listingData: widget.listingData,
                                    formData: formData,
                                  );
                                },
                              ),
                            );
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

// class ImageWithText extends StatelessWidget {
//   const ImageWithText({
//     super.key,
//     required this.text,
//     required this.onTap,
//     required this.imageName,
//   });
//   // final String imageName;
//   final String text;
//
//   final void Function()? onTap;
//   final String imageName;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           SvgIcon(imageName: 'assets/$imageName.svg'),
//           // SvgIcon(imageName: 'assets/radio_blank.svg'),
//           SizedBox(
//             width: 15.w,
//           ),
//           Text(
//             text,
//             style: kTextFieldInputStyle,
//           )
//         ],
//       ),
//     );
//   }
// }
