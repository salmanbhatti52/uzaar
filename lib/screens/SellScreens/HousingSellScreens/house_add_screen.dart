import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/Buttons.dart';
import '../../../utils/Colors.dart';
import '../../../widgets/BottomNaviBar.dart';
import '../../../widgets/TextfromFieldWidget.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

class HouseAddScreen extends StatefulWidget {
  const HouseAddScreen({Key? key}) : super(key: key);

  @override
  State<HouseAddScreen> createState() => _HouseAddScreenState();
}

class _HouseAddScreenState extends State<HouseAddScreen> {
  int noOfTabs = 2;
  late String housingDropdownValue;
  late String boostingDropdownValue;
  late int bedroomsDropdownValue;
  late int bathroomsDropdownValue;
  final nameEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final areaEditingController = TextEditingController();
  List<String> housingCategories = ['Rental', 'For Sale', 'Lease'];
  List<String> boostingOptions = ['Free', 'Paid'];
  List<int> bedrooms = [1, 2, 3, 4, 5];
  List<int> bathrooms = [1, 2, 3, 4, 5];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        child: ReusableText(text: 'Listing Name'),
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
                              SvgIcon(imageName: 'assets/list_icon.svg'),
                          hintText: 'Listing Name',
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
                      //     controller: categoryEditingController,
                      //     textInputType: TextInputType.text,
                      //     prefixIcon:
                      //         SvgIcon(imageName: 'assets/category_icon.svg'),
                      //     hintText: 'Rental',
                      //     obscureText: null,
                      //   ),
                      // ),
                      RoundedDropdownMenu(
                          leadingIconName: 'category_icon',
                          hintText: 'Rental',
                          onSelected: (value) {
                            setState(() {
                              housingDropdownValue = value;
                            });
                          },
                          dropdownMenuEntries: housingCategories
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
                        child: ReusableText(text: 'Location'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: locationEditingController,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/address-icon.svg'),
                          suffixIcon: SvgIcon(
                            imageName: 'assets/address-icon.svg',
                            colorFilter:
                                ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                          ),
                          hintText: 'Location here',
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
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Description'),
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
                        child: ReusableText(text: 'Area'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: areaEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/area_icon.svg'),
                          hintText: 'Area ( Sq.ft)',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bedroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    leadingIconName: 'bed_icon',
                                    hintText: '2',
                                    onSelected: (value) {
                                      setState(() {
                                        bedroomsDropdownValue = value;
                                      });
                                    },
                                    dropdownMenuEntries: bedrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bathroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    leadingIconName: 'bath_icon',
                                    hintText: '2',
                                    onSelected: (value) {
                                      setState(() {
                                        bathroomsDropdownValue = value;
                                      });
                                    },
                                    dropdownMenuEntries: bathrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        '*Boost your listings now to get more orders or you can boost later',
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
                      // SizedBox(
                      //   height: 50.h,
                      //   child: TextFormFieldWidget(
                      //     controller: optionEditingController,
                      //     textInputType: TextInputType.text,
                      //     prefixIcon: SvgIcon(imageName: 'assets/boost_icon.svg'),
                      //     hintText: 'Select Option',
                      //     obscureText: null,
                      //   ),
                      // ),
                      RoundedDropdownMenu(
                          leadingIconName: 'boost_icon',
                          hintText: 'Select Option',
                          onSelected: (value) {
                            setState(() {
                              boostingDropdownValue = value;
                            });
                          },
                          dropdownMenuEntries: boostingOptions
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList()),
                      SizedBox(
                        height: 14.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                      context,
                      'Publish',
                      () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BottomNavBar();
                          },
                        ),
                        (route) => false,
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
