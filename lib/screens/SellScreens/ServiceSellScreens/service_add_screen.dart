import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';

import '../../../utils/Buttons.dart';
import '../../../utils/Colors.dart';
import '../../../widgets/TextfromFieldWidget.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

class ServiceAddScreen extends StatefulWidget {
  const ServiceAddScreen({Key? key}) : super(key: key);

  @override
  State<ServiceAddScreen> createState() => _ServiceAddScreenState();
}

class _ServiceAddScreenState extends State<ServiceAddScreen> {
  int noOfTabs = 2;
  final nameEditingController = TextEditingController();
  final categoryEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final optionEditingController = TextEditingController();

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
                      child: ReusableText(text: 'Service Name'),
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
                            SvgIcon(imageName: 'assets/service_icon.svg'),
                        hintText: 'Service Name',
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
                    SizedBox(
                      height: 50.h,
                      child: TextFormFieldWidget(
                        controller: categoryEditingController,
                        textInputType: TextInputType.text,
                        prefixIcon:
                            SvgIcon(imageName: 'assets/category_icon.svg'),
                        hintText: 'Category',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(text: 'Service Description'),
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
                        hintText: 'Your Location here',
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
                    Text(
                      '*Boost your listings now to get more orders or you can boost later',
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
                    SizedBox(
                      height: 50.h,
                      child: TextFormFieldWidget(
                        controller: optionEditingController,
                        textInputType: TextInputType.text,
                        prefixIcon: SvgIcon(imageName: 'assets/boost_icon.svg'),
                        hintText: 'Select Option',
                        obscureText: null,
                      ),
                    ),
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
