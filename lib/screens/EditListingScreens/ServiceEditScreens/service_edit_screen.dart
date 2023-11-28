import 'dart:convert';

import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../../services/location.dart';
import '../../../services/restService.dart';
import '../../../utils/Buttons.dart';
import '../../../utils/colors.dart';
import '../../../widgets/snackbars.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

class ServiceEditScreen extends StatefulWidget {
  const ServiceEditScreen({super.key, required this.imagesList});

  final List<Map<String, dynamic>> imagesList;
  @override
  State<ServiceEditScreen> createState() => _ServiceEditScreenState();
}

class _ServiceEditScreenState extends State<ServiceEditScreen> {
  int noOfTabs = 2;
  late String? selectedCategoryName = '';
  late String? selectedCategoryId = '';
  late String? selectedBoostingOption = '';
  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  List<Map<String, String>> serviceCategories = [
    {'categoryName': 'Technology', 'categoryId': '8'},
    {'categoryName': 'Designing', 'categoryId': '9'},
    {'categoryName': 'Beauty', 'categoryId': '10'},
    {'categoryName': 'Medical', 'categoryId': '11'},
    {'categoryName': 'Printing', 'categoryId': '12'},
  ];
  List<String> boostingOptions = ['Free', 'Paid'];

  late double latitude;
  late double longitude;
  late Position position;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
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
          backgroundColor: Colors.white,
          leading: NavigateBack(buildContext: context),
        ),
        backgroundColor: Colors.white,
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
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
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
                      RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.887,
                          leadingIconName: 'category_icon',
                          hintText: 'Category',
                          onSelected: (value) {
                            setState(() {
                              selectedCategoryName = value['categoryName'];
                            });
                            selectedCategoryId = value['categoryId'];
                            print(selectedCategoryName);
                            print(selectedCategoryId);
                          },
                          dropdownMenuEntries: serviceCategories
                              .map(
                                (Map<String, String> value) =>
                                    DropdownMenuEntry<Object?>(
                                        value: value,
                                        label: value['categoryName'] ?? ''),
                              )
                              .toList()),
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
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
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
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: locationEditingController,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/address-icon.svg'),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              try {
                                await enableLocationService();
                                position = await getLocationCoordinates();
                                print(position);

                                List<Placemark> placemarks =
                                    await getLocationFromCoordinates(
                                        position.latitude, position.longitude);
                                print(placemarks);
                                print(
                                    '${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}');
                                setState(() {
                                  locationEditingController.text =
                                      '${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}';
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(message: e.toString()));
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     ErrorSnackBar(
                                //         message:
                                //             'Plz check your device location is on'));
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     AlertSnackBar(
                                //         message:
                                //             'we need permission to access your location'));
                              }
                            },
                            child: SvgIcon(
                              imageName: 'assets/address-icon.svg',
                              colorFilter: ColorFilter.mode(
                                  primaryBlue, BlendMode.srcIn),
                            ),
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
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
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
                        child:
                            ReusableText(text: 'Boosting Options (Optional)'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.887,
                          leadingIconName: 'boost_icon',
                          hintText: 'Select Option',
                          onSelected: (value) {
                            setState(() {
                              selectedBoostingOption = value;
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
                        context: context,
                        buttonText: setButtonStatus,
                        onTap: () async {
                          if (nameEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your service name'));
                          } else if (selectedCategoryName == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz select your service category'));
                          } else if (descriptionEditingController
                              .text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz enter your service description'));
                          } else if (locationEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz add your location'));
                          } else if (priceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your service price'));
                          } else {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            print(
                                'address: ${locationEditingController.text.toString()}');
                            setState(() {
                              setLoader = true;
                              setButtonStatus = 'Please wait..';
                            });
                            try {
                              List<Location> locations =
                                  await locationFromAddress(
                                      locationEditingController.text
                                          .toString());
                              print(locations);
                              print(locations[0].longitude);
                              print(locations[0].latitude);
                              latitude = locations[0].latitude;
                              longitude = locations[0].longitude;

                              // listings_images Required format for API call
                              // [
                              //   {'image': 'base64Image']}
                              // ]

                              // Fulfilling the requirements.
                              List<Map<String, dynamic>> images = [];

                              for (int i = 0;
                                  i < widget.imagesList.length;
                                  i++) {
                                images.add({
                                  'image': widget.imagesList[i]['image']
                                      ['imageInBase64']
                                });
                              }

                              Response response = await sendPostRequest(
                                  action: 'add_listings_services',
                                  data: {
                                    'users_customers_id':
                                        userDataGV['userId'].toString(),
                                    'listings_types_id': '2',
                                    'listings_categories_id':
                                        selectedCategoryId,
                                    'name':
                                        nameEditingController.text.toString(),
                                    'description': descriptionEditingController
                                        .text
                                        .toString(),
                                    'price':
                                        priceEditingController.text.toString(),
                                    'location': locationEditingController.text
                                        .toString(),
                                    'latitude': latitude.toString(),
                                    'longitude': longitude.toString(),
                                    'packages_id': '',
                                    'payment_gateways_id': '',
                                    'payment_status': '',
                                    'listings_images': images
                                  });
                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Save Changes';
                              });
                              print(response.statusCode);
                              print(response.body);
                              var decodedResponse = jsonDecode(response.body);
                              String status = decodedResponse['status'];
                              if (status == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: primaryBlue,
                                        content: Text(
                                          'Success',
                                          style: kToastTextStyle,
                                        )));
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BottomNavBar();
                                    },
                                  ),
                                  (route) => false,
                                );
                              }
                              if (status == 'error') {
                                String message = decodedResponse?['message'];
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          message,
                                          style: kToastTextStyle,
                                        )));
                              }
                            } catch (e) {
                              print(e);
                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Save Changes';
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Plz enter a valid address',
                                        style: kToastTextStyle,
                                      )));
                            }
                          }
                        },
                        showLoader: setLoader),
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
