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
  const ServiceEditScreen(
      {super.key, required this.listingData, required this.imagesList});
  final dynamic listingData;
  final List<Map<String, dynamic>> imagesList;
  @override
  State<ServiceEditScreen> createState() => _ServiceEditScreenState();
}

class _ServiceEditScreenState extends State<ServiceEditScreen> {
  int noOfTabs = 2;
  late String? selectedCategoryName = '';
  late int selectedCategoryId;
  String? selectedBoosting;
  dynamic selectedBoostingItem;
  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  late double latitude;
  late double longitude;
  late Position position;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
  Map? initialCategoryValue;
  Map? initialBoostingValue;
  late int? selectedSubCategoryId;
  String? selectedSubCategory;
  List subCategories = [];

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

  updateSelectedSubCategory(value) {
    setState(() {
      selectedSubCategory = value;
      print(selectedSubCategory);
    });
  }

  updateSelectedBoosting(value) {
    setState(() {
      selectedBoosting = '\$${double.parse(value['price'])} ${value['name']}';
    });
    print(selectedBoosting);
    selectedBoostingItem = value;
    print(selectedBoostingItem);
  }

  getCategorySubCategories({required int categoryId}) async {
    subCategories = [];
    selectedSubCategory = null;
    selectedSubCategoryId = null;
    Response response = await sendPostRequest(
        action: 'get_listings_sub_categories',
        data: {'listings_categories_id': categoryId});
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];

    if (mounted) {
      setState(() {
        if (status == 'success') {
          subCategories = decodedResponse['data'];
          if (widget.listingData['listings_sub_categories'] != null) {
            print('entered');
            selectedSubCategory =
                widget.listingData?['listings_sub_categories']['name'];
            selectedSubCategoryId =
                widget.listingData?['listings_sub_categories']
                    ['listings_sub_categories_id'];
          } else {
            print('not entered');
            selectedSubCategory = subCategories[0]['name'];
            selectedSubCategoryId =
                subCategories[0]['listings_sub_categories_id'];
          }
        }
      });
    }
    print(subCategories);
  }

  updateSelectedCategory(value) {
    selectedCategoryName = value['name'];
    selectedCategoryId = value['listings_categories_id'];
    getCategorySubCategories(categoryId: selectedCategoryId);
  }

  addDataToFields() {
    nameEditingController.text = widget.listingData['name'];
    descriptionEditingController.text = widget.listingData['description'];
    priceEditingController.text = widget.listingData['price'];
    locationEditingController.text = widget.listingData['location'];
    int index = serviceListingCategoriesGV.indexWhere((map) =>
        map['name'] == widget.listingData['listings_categories']['name']);
    initialCategoryValue = serviceListingCategoriesGV[index];
    updateSelectedCategory(initialCategoryValue);
    if (widget.listingData['users_customers_packages'] != null) {
      int index = boostingPackagesGV.indexWhere(
          (map) => map['name'] == widget.listingData['users_customers_packages']['packages']['name']);
      initialBoostingValue = boostingPackagesGV[index];
      updateSelectedBoosting(initialBoostingValue);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDataToFields();
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
                      const Align(
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
                              const SvgIcon(imageName: 'assets/service_icon.svg'),
                          hintText: 'Service Name',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
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
                          onSelected: updateSelectedCategory,
                          initialSelection: initialCategoryValue,
                          dropdownMenuEntries: serviceListingCategoriesGV
                              .map(
                                (dynamic value) => DropdownMenuEntry<dynamic>(
                                    value: value, label: value['name']),
                              )
                              .toList()),
                      subCategories.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 14.h,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Seller Type'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    children: List.generate(
                                        subCategories.length, (index) {
                                      return Row(
                                        children: [
                                          Radio(
                                            activeColor: primaryBlue,
                                            fillColor: const MaterialStatePropertyAll(
                                                primaryBlue),
                                            value: subCategories[index]['name'],
                                            groupValue: selectedSubCategory,
                                            onChanged: (value) {
                                              updateSelectedSubCategory(value);
                                              selectedSubCategoryId =
                                                  subCategories[index][
                                                      'listings_sub_categories_id'];
                                              print(selectedSubCategoryId);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            subCategories[index]['name'],
                                            style: kTextFieldInputStyle,
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
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
                              const SvgIcon(imageName: 'assets/description_icon.svg'),
                          hintText: 'Description here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
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
                              const SvgIcon(imageName: 'assets/address-icon.svg'),
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
                            child: const SvgIcon(
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
                      const Align(
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
                              const SvgIcon(imageName: 'assets/tag_price_bold.svg'),
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
                      const Align(
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
                        initialSelection: initialBoostingValue,
                        onSelected: updateSelectedBoosting,
                        dropdownMenuEntries: boostingPackagesGV
                            .map(
                              (dynamic value) => DropdownMenuEntry<dynamic>(
                                  value: value,
                                  label:
                                      '\$${double.parse(value['price'])} ${value['name']}'),
                            )
                            .toList(),
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

                              Response response = await sendPostRequest(
                                  action: 'edit_listings_services',
                                  data: {
                                    'listings_services_id': widget
                                        .listingData['listings_services_id'],
                                    'listings_categories_id':
                                        selectedCategoryId,
                                    'listings_sub_categories_id':
                                        selectedSubCategoryId ?? '',
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
                                    'packages_id':
                                        selectedBoostingItem?['packages_id'],
                                    'listings_images': widget.imagesList
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
                                      return const BottomNavBar(
                                        requiredScreenIndex: 0,
                                      );
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
