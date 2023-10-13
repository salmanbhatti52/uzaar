import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/screens/SellScreens/ProductSellScreens/product_add_screen_two.dart';
import 'package:sellpad/utils/Buttons.dart';
import 'package:sellpad/utils/Colors.dart';

import '../../../widgets/TextfromFieldWidget.dart';
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
    return Scaffold(
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
                    // SizedBox(
                    //   height: 50.h,
                    //   child: TextFormFieldWidget(
                    //     controller: nameEditingController,
                    //     textInputType: TextInputType.text,
                    //     prefixIcon:
                    //         SvgIcon(imageName: 'assets/category_icon.svg'),
                    //     hintText: 'Category',
                    //     obscureText: null,
                    //   ),
                    // ),
                    // DropdownMenu(
                    //     width: MediaQuery.sizeOf(context).width * 0.88,
                    //     initialSelection: productCategories.first,
                    //     onSelected: (String? value) {
                    //       setState(() {
                    //         dropDownValue = value;
                    //       });
                    //     },
                    //     dropdownMenuEntries: productCategories
                    //         .map(
                    //           (String value) => DropdownMenuEntry<String>(
                    //               value: value, label: value),
                    //         )
                    //         .toList()),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 10, right: 10, top: 5, bottom: 5),
                    //   child: DropdownButtonFormField<String>(
                    //     iconDisabledColor: Colors.transparent,
                    //     iconEnabledColor: Colors.transparent,
                    //     value: dropDownValue,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         dropDownValue = newValue;
                    //         print(dropDownValue);
                    //       });
                    //     },
                    //     items: productCategories.map((country) {
                    //           return DropdownMenuItem<String>(
                    //             value: country,
                    //             child: Text(country),
                    //           );
                    //         }).toList() ??
                    //         [],
                    //     decoration: InputDecoration(
                    //       suffixIcon: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child:
                    //                 SvgPicture.asset("assets/arrowDown1.svg"),
                    //           ),
                    //         ],
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide:
                    //             const BorderSide(color: Color(0xFFF65734)),
                    //         borderRadius: BorderRadius.circular(15.0),
                    //       ),
                    //       hintText: "Select Country",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: const BorderSide(
                    //           color: Color(0xFFF3F3F3),
                    //         ),
                    //       ),
                    //       hintStyle: const TextStyle(
                    //         color: Color(0xFFA7A9B7),
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w300,
                    //         fontFamily: "Satoshi",
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        // isExpanded: true,
                        hint: Text(
                          'Location',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryBlue,
                          ),
                        ),
                        items: productCategories
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primaryBlue,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: dropDownValue,
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value;
                          });
                        },
                        // buttonStyleData: ButtonStyleData(
                        //     height: 50,
                        //     width: 160,
                        //     padding:
                        //         const EdgeInsets.only(left: 14, right: 14),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(14),
                        //       border: Border.all(
                        //         color: Colors.black26,
                        //       ),
                        //       color: Colors.redAccent,
                        //     ),
                        //     elevation: 2,
                        //     ),
                        iconStyleData: IconStyleData(
                          icon: SvgPicture.asset('assets/drop-down-button.svg'),
                          iconEnabledColor: primaryBlue,
                          iconDisabledColor: grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          // maxHeight: 200.h,
                          // width: 140.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: white,
                          ),
                          // offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        // menuItemStyleData: const MenuItemStyleData(
                        //   height: 40,
                        //   padding: EdgeInsets.only(left: 14, right: 14),
                        // ),
                      ),
                    ),
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
                          imageName: selectedProductCondition == Condition.fresh
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
                          imageName: selectedProductCondition == Condition.used
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
