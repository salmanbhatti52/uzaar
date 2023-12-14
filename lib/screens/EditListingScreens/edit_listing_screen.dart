import 'package:Uzaar/screens/EditListingScreens/HousingEditScreens/house_edit_screen.dart';
import 'package:Uzaar/screens/EditListingScreens/ProductEditScreens/product_edit_screen_one.dart';
import 'package:Uzaar/screens/EditListingScreens/ServiceEditScreens/service_edit_screen.dart';
import 'package:Uzaar/services/restService.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import '../../services/getImage.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';

import '../../widgets/snackbars.dart';
import '../../widgets/tab_indicator.dart';

import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class EditListingScreen extends StatefulWidget {
  const EditListingScreen(
      {super.key,
      required this.selectedListingType,
      required this.listingData});
  final int selectedListingType;
  final dynamic listingData;

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  int selectedListingType = 1;
  int noOfTabs = 3;
  String selectedImageInBase64 = '';
  late Map<String, dynamic> images;
  List<Map<String, dynamic>> imagesList = [];
  List<int> removedImagesIds = [];
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

  List<dynamic> listedImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedListingType = widget.selectedListingType;
    print('widget.listingData: ${widget.listingData}');
    init();
  }

  init() {
    listedImages = [...widget.listingData['listings_images']];
    setState(() {});
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
                        if (selectedListingType == 3) {
                          if (listedImages.length < 20) {
                            images = await getImage(from: 'camera');
                            if (images.isNotEmpty) {
                              listedImages.add(images);
                              imagesList.add(images);
                              setState(() {});
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'You can add maximum twenty images.'));
                          }
                        } else {
                          if (listedImages.length < 6) {
                            images = await getImage(from: 'camera');
                            if (images.isNotEmpty) {
                              listedImages.add(images);
                              imagesList.add(images);
                              setState(() {});
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'You can add maximum six images.'));
                          }
                        }

                        // images = await getImage(from: 'camera');
                        // if (images.isNotEmpty) {
                        //   setState(() {
                        //     _selectedImage = images['image']['imageInXFile'];
                        //   });
                        //   selectedImageInBase64 =
                        //       images['image']['imageInBase64'];
                        // }
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
                        if (selectedListingType == 3) {
                          if (listedImages.length < 20) {
                            List<Map<String, dynamic>> pickedImages =
                                await pickMultiImage();
                            if (pickedImages.isNotEmpty) {
                              for (int i = 0; i < pickedImages.length; i++) {
                                imagesList.add(pickedImages[i]);
                                listedImages.add(pickedImages[i]);
                              }
                            }
                            print(imagesList.length);
                            if (imagesList.length > 20) {
                              imagesList = imagesList.sublist(0, 20);
                            }
                            print(imagesList.length);

                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'You can add maximum twenty images.'));
                          }
                        } else {
                          if (listedImages.length < 6) {
                            List<Map<String, dynamic>> pickedImages =
                                await pickMultiImage();
                            if (pickedImages.isNotEmpty) {
                              for (int i = 0; i < pickedImages.length; i++) {
                                imagesList.add(pickedImages[i]);
                                listedImages.add(pickedImages[i]);
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
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/upload-pic.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                // listedImages.isNotEmpty ?
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                        listedImages.length,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: primaryBlue,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )),
                              child: listedImages.length > index
                                  ? Stack(
                                      children: [
                                        listedImages[index]
                                                    ['listings_images_id'] !=
                                                null
                                            ? Container(
                                                height: 94,
                                                width: 94,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    imgBaseUrl +
                                                        listedImages[index]
                                                            ['image'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 94,
                                                width: 94,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.file(
                                                    // File(_selectedImage!.path),
                                                    File(listedImages[index]
                                                                ['image']
                                                            ['imageInXFile']
                                                        .path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                        Positioned(
                                          top: 6,
                                          right: 6,
                                          child: GestureDetector(
                                            onTap: () async {
                                              print(index);
                                              if (listedImages[index]
                                                      ['listings_images_id'] !=
                                                  null) {
                                                int id = listedImages[index]
                                                    ['listings_images_id'];
                                                print(id);
                                                listedImages.removeAt(index);
                                                removedImagesIds.add(id);
                                              } else {
                                                dynamic imageToRemove =
                                                    await listedImages[index];
                                                listedImages.removeAt(index);
                                                imagesList
                                                    .remove(imageToRemove);
                                              }

                                              // _selectedImage = null;
                                              setState(() {});
                                              print(removedImagesIds);
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
                                  : const Icon(
                                      Icons.image,
                                      size: 94,
                                      color: Colors.grey,
                                    ),
                            ))),
                // Wrap(
                //   spacing: 8,
                //   runSpacing: 8,
                //   // alignment: WrapAlignment.spaceBetween,
                //   children: List.generate(
                //       6 - listedImages.length,
                //       (index) => Container(
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(5),
                //                 border: Border.all(
                //                   color: primaryBlue,
                //                   width: 1,
                //                   style: BorderStyle.solid,
                //                 )),
                //             child: imagesList.length > index
                //                 ? Stack(
                //                     children: [
                //                       Container(
                //                         height: 94,
                //                         width: 94,
                //                         child: ClipRRect(
                //                           borderRadius:
                //                               BorderRadius.circular(5),
                //                           child: Image.file(
                //                             // File(_selectedImage!.path),
                //                             File(imagesList[index]['image']
                //                                     ['imageInXFile']
                //                                 .path),
                //                             fit: BoxFit.cover,
                //                           ),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         top: 6,
                //                         right: 6,
                //                         child: GestureDetector(
                //                           onTap: () {
                //                             print('tapped: $index');
                //
                //                             imagesList.removeAt(index);
                //                             // listedImage = '';
                //                             // _selectedImage = null;
                //                             setState(() {});
                //                           },
                //                           child: SvgPicture.asset(
                //                             'assets/remove.svg',
                //                             height: 20,
                //                             width: 20,
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   )
                //                 : const Icon(
                //                     Icons.image,
                //                     size: 94,
                //                     color: Colors.grey,
                //                   ),
                //           )),
                // ),
                //      SizedBox(
                // height: 190,
                // ),
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
                        // listings_images Required format for API call
                        // [
                        //   {'image': 'base64Image']}
                        // ]

                        // Fulfilling the requirements.
                        List<Map<String, dynamic>> pickedImages = [];
                        for (int i = 0; i < imagesList.length; i++) {
                          pickedImages.add({
                            'listings_images_id': removedImagesIds[i],
                            'image': imagesList[i]['image']['imageInBase64']
                          });
                        }
                        print(pickedImages);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return selectedListingType == 1
                                  ? ProductEditScreenOne(
                                      imagesList: pickedImages,
                                      listingData: widget.listingData,
                                    )
                                  : selectedListingType == 2
                                      ? ServiceEditScreen(
                                          imagesList: pickedImages,
                                          listingData: widget.listingData,
                                        )
                                      : HouseEditScreen(
                                          imagesList: pickedImages,
                                          listingData: widget.listingData,
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
