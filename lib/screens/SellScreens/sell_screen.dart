import 'dart:convert';

import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Uzaar/screens/SellScreens/HousingSellScreens/house_add_screen.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_one.dart';
import 'package:Uzaar/screens/SellScreens/ServiceSellScreens/service_add_screen.dart';
import 'dart:io';
import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/getImage.dart';
import '../../services/restService.dart';
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
  int selectedListingType = 1;
  int noOfTabs = 3;
  // XFile? _selectedImage;
  // String? selectedImageInBase64 = '';
  late Map<String, dynamic> images;
  List<Map<String, dynamic>> imagesList = [];
  int _tapCount = 0;

  List<dynamic> boostingPackages = [...boostingPackagesGV];

  getBoostingPackages() async {
    Response response = await sendGetRequest('get_packages');

    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    boostingPackagesGV = [];
    if (status == 'success') {
      boostingPackagesGV = decodedData['data'];
      if (mounted) {
        setState(() {
          boostingPackagesGV.removeAt(3);
          boostingPackages = boostingPackagesGV;
        });
      }
    }
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    if (selectedListingType != 1) {
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

  init() {
    getBoostingPackages();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _tapCount++;
        print(_tapCount);
        if (_tapCount == 1) {
        } else if (_tapCount >= 2) {
          // Pop the navigator after the second tap
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70,
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SvgPicture.asset(
                  'assets/drawer-button.svg',
                  fit: BoxFit.scaleDown,
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
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
                  Text(
                    'What do you want to sell?',
                    style: kBodySubHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listingTypesGV.isNotEmpty
                        ? List.generate(
                            listingTypesGV.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedListingType = listingTypesGV[index]
                                      ['listings_types_id'];
                                  imagesList = [];
                                  getPageIndicators();
                                });
                                print(
                                    'selectedListingType: $selectedListingType');
                              },
                              child: BusinessTypeButton(
                                  margin: index < listingTypesGV.length - 1
                                      ? EdgeInsets.only(right: 10)
                                      : null,
                                  businessName: listingTypesGV[index]['name'],
                                  gradient: selectedListingType ==
                                          listingTypesGV[index]
                                              ['listings_types_id']
                                      ? gradient
                                      : null,
                                  buttonBackground: selectedListingType !=
                                          listingTypesGV[index]
                                              ['listings_types_id']
                                      ? grey.withOpacity(0.3)
                                      : null,
                                  textColor: selectedListingType ==
                                          listingTypesGV[index]
                                              ['listings_types_id']
                                      ? white
                                      : grey),
                            ),
                          )
                        : List.generate(
                            3,
                            (index) => Shimmer.fromColors(
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!,
                                child: BusinessTypeButton(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    businessName: '',
                                    gradient: null,
                                    buttonBackground: grey.withOpacity(0.3),
                                    textColor: grey)),
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
                          if (imagesList.length < 6) {
                            images = await getImage(from: 'camera');
                            if (images.isNotEmpty) {
                              imagesList.add(images);
                              setState(() {});
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'You can add maximum six images.'));
                          }
                        },
                        child: SvgPicture.asset('assets/add-pic-button.svg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: kUploadImageBoxBorderShadow,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () async {
                          if (imagesList.length < 6) {
                            List<Map<String, dynamic>> pickedImages =
                                await pickMultiImage();
                            if (pickedImages.isNotEmpty) {
                              for (int i = 0; i < pickedImages.length; i++) {
                                imagesList.add(pickedImages[i]);
                              }
                            }
                            print(imagesList.length);
                            if (imagesList.length > 6) {
                              imagesList = imagesList.sublist(0, 6);
                            }
                            print(imagesList.length);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'You can add maximum six images.'));
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/upload-pic.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    // alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: List.generate(
                        6,
                        (index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: primaryBlue,
                                  width: 1,
                                  style: BorderStyle.solid,
                                )),
                            child: index < imagesList.length
                                ? Stack(
                                    children: [
                                      Container(
                                          height: 94,
                                          width: 94,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.file(
                                              File(imagesList[index]['image']
                                                      ['imageInXFile']
                                                  .path),
                                              // File(_selectedImage!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: GestureDetector(
                                          onTap: () {
                                            print('tapped: $index');
                                            imagesList.removeAt(index);
                                            // listedImage = '';
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
                                  )
                                : Icon(
                                    Icons.image,
                                    size: 94,
                                    color: Colors.grey,
                                  ))),
                  ),
                  // SizedBox(
                  //         height: MediaQuery.sizeOf(context).height * 0.25,
                  //       ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  primaryButton(
                      context: context,
                      buttonText: 'Next',
                      onTap: () {
                        if (imagesList.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              ErrorSnackBar(message: 'Please add six images'));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return selectedListingType == 1
                                    ? ProductAddScreenOne(
                                        imagesList: imagesList,
                                      )
                                    : selectedListingType == 2
                                        ? ServiceAddScreen(
                                            imagesList: imagesList,
                                          )
                                        : HouseAddScreen(
                                            imagesList: imagesList,
                                          );
                              },
                            ),
                          );
                        }
                      },
                      showLoader: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
