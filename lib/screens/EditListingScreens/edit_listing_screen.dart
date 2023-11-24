import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
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
  const EditListingScreen(
      {super.key, required this.selectedCategory, required this.listingData});
  final int selectedCategory;
  final dynamic listingData;

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  int selectedCategory = 1;
  int noOfTabs = 3;
  XFile? _selectedImage;
  String selectedImageInBase64 = '';
  late Map<String, dynamic> images;
  List<Map<String, dynamic>> imageList = [];

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

  String listedImage = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = widget.selectedCategory;
    print(widget.listingData);
    init();
  }

  init() async {
    listedImage = widget.listingData['listings_images'][0]['image'];
    print('listedImage: $listedImage');
    // listedImages = await widget.listingData['listings_images'];
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
        child: SingleChildScrollView(
          child: Container(
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
                        if (images.isNotEmpty) {
                          setState(() {
                            _selectedImage = images['selectedImage'];
                          });
                          selectedImageInBase64 =
                              images['selectedImageInBase64'];
                        }
                      },
                      child: SvgPicture.asset('assets/add-pic-button.svg'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: kUploadImageBoxBorderShadow,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () async {
                        imageList = await pickMultiImage();
                        print(imageList);
                        setState(() {});
                        // images = await getImage(from: 'gallery');
                        // if (images.isNotEmpty) {
                        //   setState(() {
                        //     _selectedImage = images['selectedImage'];
                        //   });
                        //   selectedImageInBase64 =
                        //       images['selectedImageInBase64'];
                        // }
                      },
                      child: SvgPicture.asset(
                        'assets/upload-pic.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                imageList.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        // alignment: WrapAlignment.spaceBetween,
                        children: List.generate(
                            imageList.length,
                            (index) => Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 16),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          // File(_selectedImage!.path),
                                          File(imageList[index]['image$index']
                                                  ['imageInXFile']
                                              .path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 22,
                                      right: 6,
                                      child: GestureDetector(
                                        onTap: () {
                                          print('tapped: $index');
                                          imageList.removeAt(index);
                                          listedImage = '';
                                          // _selectedImage = null;
                                          setState(() {});
                                        },
                                        child: SvgPicture.asset(
                                          'assets/remove.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                      )
                    : listedImage.isNotEmpty
                        ? Stack(
                            children: [
                              Container(
                                height: 190,
                                width: MediaQuery.sizeOf(context).width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imgBaseUrl + listedImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    listedImage = '';
                                    // _selectedImage = null;
                                    setState(() {});
                                  },
                                  child: SvgPicture.asset(
                                    'assets/remove.svg',
                                    // height: 20,
                                    // width: 20,
                                  ),
                                ),
                              )
                            ],
                          )
                        : SizedBox(
                            height: 190,
                          ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.11,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  // padding: EdgeInsets.only(bottom: 20.0),
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
      ),
    );
  }
}
