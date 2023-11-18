import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/getImage.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';

import '../../widgets/tab_indicator.dart';
import '../SellScreens/HousingSellScreens/house_add_screen.dart';
import '../SellScreens/ProductSellScreens/product_add_screen_one.dart';
import '../SellScreens/ServiceSellScreens/service_add_screen.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class EditListingScreen extends StatefulWidget {
  EditListingScreen({
    super.key,
    required this.selectedCategory,
  });
  int selectedCategory;

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  int selectedCategory = 1;
  int noOfTabs = 3;
  XFile? _selectedImage;
  String selectedImageInBase64 = '';
  late Map<String, dynamic> images;

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
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/back-arrow-button.svg',
            fit: BoxFit.scaleDown,
          ),
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
          'Edit Listings',
          style: kAppBarTitleStyle,
        ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload or Take Picture',
                    style: kBodyTextStyle,
                  ),
                  GestureDetector(
                    onTap: () async {
                      images = await getImage(from: 'camera');
                      setState(() {
                        _selectedImage = images['selectedImage'];
                      });
                      selectedImageInBase64 = images['selectedImageInBase64'];
                    },
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
                  child: GestureDetector(
                    onTap: () async {
                      images = await getImage(from: 'gallery');
                      setState(() {
                        _selectedImage = images['selectedImage'];
                      });
                      selectedImageInBase64 = images['selectedImageInBase64'];
                    },
                    child: SvgPicture.asset(
                      'assets/upload-pic.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              _selectedImage != null
                  ? Container(
                      height: MediaQuery.sizeOf(context).height * 0.30,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: primaryButton(
                    context: context,
                    buttonText: 'Next',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return selectedCategory == 1
                                ? ProductAddScreenOne(
                                    productBase64Image: selectedImageInBase64,
                                    editDetails: true,
                                  )
                                : selectedCategory == 2
                                    ? ServiceAddScreen(
                                        serviceBase64Image:
                                            selectedImageInBase64,
                                        editDetails: true,
                                      )
                                    : HouseAddScreen(
                                        housingBase64Image:
                                            selectedImageInBase64,
                                        editDetails: true,
                                      );
                          },
                        ),
                      );
                    },
                    showLoader: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
