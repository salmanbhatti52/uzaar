import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/tab_indicator.dart';
import 'ProductSellScreens/product_add_screen_two.dart';

class AddItemImageScreen extends StatefulWidget {
  const AddItemImageScreen({Key? key}) : super(key: key);

  @override
  State<AddItemImageScreen> createState() => _AddItemImageScreenState();
}

class _AddItemImageScreenState extends State<AddItemImageScreen> {
  int selectedCategory = 1;
  int noOfTabs = 3;
  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    if (selectedCategory != 1) {
      noOfTabs = 2;
    } else {
      noOfTabs = 3;
    }
    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 1 ? null : grey,
        gradient: i == 1 ? gradient : null,
        margin: i == noOfTabs ? null : EdgeInsets.only(right: 10.w),
      );
      tabs.add(tab);
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
