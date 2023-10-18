import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_two.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/Colors.dart';

import '../../../widgets/TextfromFieldWidget.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

enum Condition { fresh, used }

class ProductAddScreenOne extends StatefulWidget {
  static const String id = 'product_add_screen_one';
  const ProductAddScreenOne({Key? key}) : super(key: key);

  @override
  State<ProductAddScreenOne> createState() => _ProductAddScreenOneState();
}

class _ProductAddScreenOneState extends State<ProductAddScreenOne> {
  int noOfTabs = 3;

  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  List<String> productCategories = [
    'Electronic',
    'Vehicle',
    'Fashion',
    'Books'
  ];
  late String? dropDownValue;

  Condition selectedProductCondition = Condition.fresh;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = productCategories.first;
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 2 ? null : grey,
        gradient: i == 2 ? gradient : null,
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
          backgroundColor: white,
          leading: NavigateBack(buildContext: context),
        ),
        backgroundColor: white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: ReusableText(text: 'Product Name'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: nameEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/product_icon.svg'),
                          hintText: 'Product Name',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Category'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                          leadingIconName: 'category_icon',
                          hintText: 'Category',
                          onSelected: (value) {
                            setState(() {
                              dropDownValue = value;
                            });
                          },
                          dropdownMenuEntries: productCategories
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList()),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Condition'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        children: [
                          ImageWithText(
                            onTap: () {
                              setState(() {
                                selectedProductCondition = Condition.fresh;
                              });
                            },
                            text: 'New',
                            imageName:
                                selectedProductCondition == Condition.fresh
                                    ? 'radio_filled'
                                    : 'radio_blank',
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          ImageWithText(
                            onTap: () {
                              setState(() {
                                selectedProductCondition = Condition.used;
                              });
                            },
                            text: 'Used',
                            imageName:
                                selectedProductCondition == Condition.used
                                    ? 'radio_filled'
                                    : 'radio_blank',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Product Description'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: descriptionEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/description_icon.svg'),
                          hintText: 'Description here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Price'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: priceEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Price',
                          obscureText: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                      context,
                      'Next',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductAddScreenTwo();
                          },
                        ),
                      ),
                    ),
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

class ImageWithText extends StatelessWidget {
  const ImageWithText({
    super.key,
    required this.text,
    required this.onTap,
    required this.imageName,
  });
  // final String imageName;
  final String text;

  final void Function()? onTap;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgIcon(imageName: 'assets/$imageName.svg'),
          // SvgIcon(imageName: 'assets/radio_blank.svg'),
          SizedBox(
            width: 15.w,
          ),
          Text(
            text,
            style: kTextFieldInputStyle,
          )
        ],
      ),
    );
  }
}
