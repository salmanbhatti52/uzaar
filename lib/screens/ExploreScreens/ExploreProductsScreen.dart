import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';

class ExploreProductsScreen extends StatefulWidget {
  const ExploreProductsScreen({super.key});

  @override
  State<ExploreProductsScreen> createState() => _ExploreProductsScreenState();
}

class _ExploreProductsScreenState extends State<ExploreProductsScreen> {
  bool selectedCategory = false;
  bool selectedPrice = false;
  bool selectedLocation = false;

  String? selectedValue;
  String? price;

  final List<String> items = [
    'Electronics',
    'Vehicles',
    'Books',
    'Accessories',
    'Furniture',
    'Fashion',
    'Sports',
  ];

  final List<String> locations = [
    'Multan',
    'Lahore',
    'Karachi',
  ];

  final List<String> prices = [
    '0-40',
    '40-80',
    '80-120',
    '120-160',
    '160-200',
    '200-240',
    '240-280',
    '280-320',
    '320-360',
    '360-400',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = !selectedCategory;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  // margin: EdgeInsets.only(bottom: 20.h),
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      selectedCategory
                          ? SvgPicture.asset('assets/cat-selcected.svg')
                          : SvgPicture.asset('assets/cat-unselect.svg'),
                      SizedBox(
                        width: 4.w,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          // isExpanded: true,
                          hint: Text(
                            'Category',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryBlue,
                            ),
                          ),
                          items: items
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
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },

                          iconStyleData: IconStyleData(
                            icon:
                                SvgPicture.asset('assets/drop-down-button.svg'),
                            iconEnabledColor: primaryBlue,
                            iconDisabledColor: grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: white,
                            ),
                            offset: const Offset(-20, 0),
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  selectedLocation = !selectedLocation;
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  // margin: EdgeInsets.only(bottom: 20.h),
                  width: 155.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      selectedLocation
                          ? SvgPicture.asset('assets/cat-selcected.svg')
                          : SvgPicture.asset('assets/cat-unselect.svg'),
                      SizedBox(
                        width: 4.w,
                      ),
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
                          items: items
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
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
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
                            icon:
                                SvgPicture.asset('assets/drop-down-button.svg'),
                            iconEnabledColor: primaryBlue,
                            iconDisabledColor: grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200.h,
                            width: 140.w,
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  selectedPrice = !selectedPrice;
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  // margin: EdgeInsets.only(bottom: 20.h),
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      selectedPrice
                          ? SvgPicture.asset('assets/cat-selcected.svg')
                          : SvgPicture.asset('assets/cat-unselect.svg'),
                      SizedBox(
                        width: 8.w,
                      ),
                      DropdownButtonHideUnderline(
                        child: Expanded(
                          child: DropdownButton2<String>(
                            // isExpanded: true,
                            hint: Text(
                              'Price',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryBlue,
                              ),
                            ),
                            items: prices
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
                            value: price,
                            onChanged: (value) {
                              setState(() {
                                price = value;
                              });
                            },

                            iconStyleData: IconStyleData(
                              icon: SvgPicture.asset(
                                  'assets/drop-down-button.svg'),
                              iconEnabledColor: primaryBlue,
                              iconDisabledColor: grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              padding: EdgeInsets.only(right: 15.w),
                              maxHeight: 200.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: white,
                              ),
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
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
          height: 500.h,
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 14.w),
              shrinkWrap: true,
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.85,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0.w,
                  mainAxisSpacing: 15.0.h),
              itemBuilder: (BuildContext context, int index) {
                return FeaturedProductsWidget(
                  image: 'assets/place-holder.png',
                  productCategory: 'Fashion',
                  productDescription: 'Product Description',
                  productLocation: 'Product Location',
                  productPrice: '20',
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
