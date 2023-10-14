import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';
import 'package:sellpad/widgets/rounded_dropdown_menu.dart';

import '../../../utils/Buttons.dart';
import '../../../utils/Colors.dart';
import '../../../widgets/TextfromFieldWidget.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

class ProductAddScreenTwo extends StatefulWidget {
  static const String id = 'product_add_screen_two';
  const ProductAddScreenTwo({Key? key}) : super(key: key);

  @override
  State<ProductAddScreenTwo> createState() => _ProductAddScreenTwoState();
}

class _ProductAddScreenTwoState extends State<ProductAddScreenTwo> {
  int noOfTabs = 3;
  final priceEditingController = TextEditingController();
  late String dropdownValue;
  List<String> boostingOptions = ['Free', 'Paid'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
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
                      child: ReusableText(text: 'Add Minimum Offer Price '),
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
                      child: ReusableText(text: 'Boosting Options (Optional)'),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedDropdownMenu(
                      leadingIconName: 'boost_icon',
                      hintText: 'Select Option',
                      onSelected: (value) {
                        setState(() {
                          dropdownValue = value;
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
                  height: MediaQuery.of(context).size.height * 0.49,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: primaryButton(
                    context,
                    'Publish',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BottomNavBar();
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
