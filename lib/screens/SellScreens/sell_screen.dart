import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Uzaar/screens/SellScreens/HousingSellScreens/house_add_screen.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_one.dart';
import 'package:Uzaar/screens/SellScreens/ServiceSellScreens/service_add_screen.dart';

import 'package:Uzaar/utils/colors.dart';

import '../../utils/Buttons.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/business_type_button.dart';
import '../../widgets/tab_indicator.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  int selectedPage = 0;
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SvgPicture.asset(
                  'assets/drawer-button.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessagesScreen(),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/msg-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/notification-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ],
        centerTitle: false,
        title: Text(
          'Sell',
          style: kAppBarTitleStyle,
        ),
      ),
      drawer: DrawerWidget(
        buildContext: context,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          child: Column(
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
              Text(
                'What do you want to sell?',
                style: kBodySubHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 1;
                        getPageIndicators();
                      });
                    },
                    child: BusinessTypeButton(
                        businessName: 'Products',
                        gradient: selectedCategory == 1 ? gradient : null,
                        buttonBackground: selectedCategory != 1
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 1 ? white : grey),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 2;
                        getPageIndicators();
                      });
                    },
                    child: BusinessTypeButton(
                        businessName: 'Services',
                        gradient: selectedCategory == 2 ? gradient : null,
                        buttonBackground: selectedCategory != 2
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 2 ? white : grey),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 3;
                        getPageIndicators();
                      });
                    },
                    child: BusinessTypeButton(
                        businessName: 'Housing',
                        gradient: selectedCategory == 3 ? gradient : null,
                        buttonBackground: selectedCategory != 3
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 3 ? white : grey),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload or Take Picture',
                    style: kBodyTextStyle,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: SvgPicture.asset('assets/add-pic-button.svg'),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 165,
                width: double.infinity,
                decoration: kUploadImageBoxBorderShadow,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SvgPicture.asset(
                    'assets/upload-pic.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: primaryButton(context, 'Next', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return selectedCategory == 1
                            ? ProductAddScreenOne()
                            : selectedCategory == 2
                                ? ServiceAddScreen()
                                : HouseAddScreen();
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
