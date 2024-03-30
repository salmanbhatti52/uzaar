import 'dart:convert';

import 'package:uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../../services/location.dart';
import '../../../services/restService.dart';
import '../../../utils/Buttons.dart';
import '../../../utils/colors.dart';
import '../../../widgets/BottomNaviBar.dart';
import '../../../widgets/snackbars.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';
import '../../BusinessDetailPages/payment_screen.dart';

enum FurnishedConditions { yes, no }

class HouseEditScreen extends StatefulWidget {
  const HouseEditScreen(
      {super.key, required this.listingData, required this.imagesList});
  final dynamic listingData;
  final List<Map<String, dynamic>> imagesList;
  @override
  State<HouseEditScreen> createState() => _HouseEditScreenState();
}

class _HouseEditScreenState extends State<HouseEditScreen> {
  int noOfTabs = 2;
  late String? selectedCategoryName = '';
  late int selectedCategoryId;
  String? selectedBoosting;
  dynamic selectedBoostingItem;
  late int? selectedBedroomOption = 0;
  late int? selectedBathroomOption = 0;
  final nameEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final areaEditingController = TextEditingController();

  List<int> bedrooms = [1, 2, 3, 4, 5];
  List<int> bathrooms = [1, 2, 3, 4, 5];

  late double latitude;
  late double longitude;
  late Position position;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
  Map? initialCategoryValue;
  Map? initialBoostingValue;
  Object? initialBedroomsValue;
  Object? initialBathroomsValue;
  FurnishedConditions? _selectedCondition = FurnishedConditions.no;

  late int? selectedSubCategoryId;
  String? selectedSubCategory;
  List subCategories = [];

  updateSelectedCondition(value) {
    _selectedCondition = value;
    print(_selectedCondition);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDataToFields();
  }

  addDataToFields() {
    nameEditingController.text = widget.listingData['name'];
    descriptionEditingController.text = widget.listingData['description'];
    priceEditingController.text = widget.listingData['price'];
    locationEditingController.text = widget.listingData['location'];
    areaEditingController.text = widget.listingData['area'];

    _selectedCondition = widget.listingData['furnished'] == 'Yes'
        ? FurnishedConditions.yes
        : FurnishedConditions.no;
    int categoryIndex = housingListingCategoriesGV.indexWhere((map) =>
        map['name'] == widget.listingData['listings_categories']['name']);
    initialCategoryValue = housingListingCategoriesGV[categoryIndex];
    updateSelectedCategory(initialCategoryValue);

    if (widget.listingData['users_customers_packages'] != null) {
      int index = boostingPackagesGV.indexWhere((map) =>
          map['name'] ==
          widget.listingData['users_customers_packages']['packages']['name']);
      initialBoostingValue = boostingPackagesGV[index];
      // updateSelectedBoosting(initialBoostingValue);
    }

    int bedroomsValIndex =
        bedrooms.indexOf(int.parse(widget.listingData['bedroom']));
    initialBedroomsValue = bedrooms[bedroomsValIndex];
    print(initialBedroomsValue);
    updateBedroomsValue(initialBedroomsValue);

    int bathroomsValIndex =
        bathrooms.indexOf(int.parse(widget.listingData['bathroom']));
    initialBathroomsValue = bathrooms[bathroomsValIndex];
    print(initialBathroomsValue);
    updateBathroomsValue(initialBathroomsValue);
  }

  updateSelectedCategory(value) {
    selectedCategoryName = value['name'];
    selectedCategoryId = value['listings_categories_id'];
    getCategorySubCategories(categoryId: selectedCategoryId);
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

    if (sellerMultiListingPackageGV.isNotEmpty &&
        sellerMultiListingPackageGV['payment_status'] == 'Paid' &&
        value['name'] != sellerMultiListingPackageGV['packages']['name']) {
      ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
          message:
              'You have the subscription of Monthly Unlimited Boosting package.'));
    }
  }

  boostIndividualListing(
      {required listingsHousingsId, required usersCustomersPkgsId}) async {
    setState(() {
      setLoader = true;
      setButtonStatus = 'Please wait..';
    });
    Response response =
        await sendPostRequest(action: 'boost_listings_individually', data: {
      "users_customers_packages_id": usersCustomersPkgsId,
      "listings_products_id": "",
      "listings_services_id": "",
      "listings_housings_id": listingsHousingsId
    });
    setState(() {
      setLoader = false;
      setButtonStatus = 'Save Changes';
    });
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
          SuccessSnackBar(message: 'Your listing boosted successfully'));
    } else if (status == 'error') {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: decodedResponse['message']));
    } else {}
    // ignore: use_build_context_synchronously
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

  updateBedroomsValue(value) {
    selectedBedroomOption = value;
  }

  updateBathroomsValue(value) {
    selectedBathroomOption = value;
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'House Name'),
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
                              const SvgIcon(imageName: 'assets/list_icon.svg'),
                          hintText: 'House Name',
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
                          dropdownMenuEntries: housingListingCategoriesGV
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
                                            fillColor:
                                                const MaterialStatePropertyAll(
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
                        child: ReusableText(text: 'Furnished'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor: const MaterialStatePropertyAll(
                                      primaryBlue),
                                  value: FurnishedConditions.yes,
                                  groupValue: _selectedCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Yes',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor: const MaterialStatePropertyAll(
                                      primaryBlue),
                                  value: FurnishedConditions.no,
                                  groupValue: _selectedCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'No',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
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
                          prefixIcon: const SvgIcon(
                              imageName: 'assets/address-icon.svg'),
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
                          hintText: 'Location here',
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
                          prefixIcon: const SvgIcon(
                              imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Price',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Description'),
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
                          prefixIcon: const SvgIcon(
                              imageName: 'assets/description_icon.svg'),
                          hintText: 'Description here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Area'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: areaEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              const SvgIcon(imageName: 'assets/area_icon.svg'),
                          hintText: 'Area ( Sq.ft)',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bedroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    leadingIconName: 'bed_icon',
                                    hintText: '2',
                                    initialSelection: initialBedroomsValue,
                                    onSelected: updateBedroomsValue,
                                    dropdownMenuEntries: bedrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bathroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    leadingIconName: 'bath_icon',
                                    hintText: '2',
                                    initialSelection: initialBathroomsValue,
                                    onSelected: updateBathroomsValue,
                                    dropdownMenuEntries: bathrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          )
                        ],
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
                        onSelected: updateSelectedBoosting,
                        initialSelection: initialBoostingValue,
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
                                    message: 'Plz enter your house name'));
                          } else if (selectedCategoryName == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select your house category'));
                          } else if (locationEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz add your location'));
                          } else if (priceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your house price'));
                          } else if (descriptionEditingController
                              .text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz enter your house description'));
                          } else if (areaEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz add your house area'));
                          } else if (selectedBedroomOption == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select no. of bedrooms'));
                          } else if (selectedBathroomOption == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select no. of bathrooms'));
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
                                  action: 'edit_listings_housings',
                                  data: {
                                    'listings_housings_id': widget
                                        .listingData['listings_housings_id'],
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
                                    'furnished': _selectedCondition ==
                                            FurnishedConditions.yes
                                        ? 'Yes'
                                        : 'No',
                                    'area':
                                        areaEditingController.text.toString(),
                                    'bedroom': selectedBedroomOption.toString(),
                                    'bathroom':
                                        selectedBathroomOption.toString(),
                                    'packages_id': sellerMultiListingPackageGV
                                                .isNotEmpty &&
                                            sellerMultiListingPackageGV[
                                                    'payment_status'] ==
                                                'Paid' &&
                                            selectedBoostingItem?[
                                                    'packages_id'] !=
                                                sellerMultiListingPackageGV[
                                                    'packages']['packages_id']
                                        ? ""
                                        : sellerMultiListingPackageGV
                                                    .isNotEmpty &&
                                                selectedBoostingItem?[
                                                        'packages_id'] ==
                                                    sellerMultiListingPackageGV[
                                                            'packages']
                                                        ['packages_id']
                                            ? ""
                                            : selectedBoostingItem?[
                                                'packages_id'],
                                    // 'payment_gateways_id': '',
                                    // 'payment_status': '',
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
                              Map data = decodedResponse['data'];
                              if (status == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SuccessSnackBar(message: null));
                                if (data['featured'] == 'No') {
                                  if (selectedBoostingItem?['packages_id'] !=
                                      null) {
                                    // ================inner if-else starting below==================
                                    //============ start case: selecting any boost listing package
                                    if (sellerMultiListingPackageGV.isEmpty) {
                                      print(
                                          'multi-listing pkg not subscribed, and chosen a different package');
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => PaymentScreen(
                                                        buyTheProduct: false,
                                                        buyTheBoosting: true,
                                                        listingHousingId: data[
                                                            'listings_housings_id'],
                                                        selectedPackage: data[
                                                                'users_customers_packages']
                                                            ['packages'],
                                                        userCustomerPackagesId:
                                                            data['users_customers_packages']
                                                                [
                                                                'users_customers_packages_id'],
                                                      )),
                                          (route) => false);
                                    }
                                    //============ cases: for selecting a different package other than multi-listing

                                    else if (sellerMultiListingPackageGV
                                            .isNotEmpty &&
                                        sellerMultiListingPackageGV[
                                                'payment_status'] ==
                                            'Unpaid' &&
                                        selectedBoostingItem?['packages_id'] !=
                                            sellerMultiListingPackageGV['packages']
                                                ['packages_id']) {
                                      print(
                                          'multi-listing already subscribed, not bought, and chosen a different package');
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => PaymentScreen(
                                                        buyTheProduct: false,
                                                        buyTheBoosting: true,
                                                        listingHousingId: data[
                                                            'listings_housings_id'],
                                                        selectedPackage: data[
                                                                'users_customers_packages']
                                                            ['packages'],
                                                        userCustomerPackagesId:
                                                            data['users_customers_packages']
                                                                [
                                                                'users_customers_packages_id'],
                                                      )),
                                          (route) => false);
                                    } else if (sellerMultiListingPackageGV
                                            .isNotEmpty &&
                                        sellerMultiListingPackageGV[
                                                'payment_status'] ==
                                            'Paid' &&
                                        selectedBoostingItem?['packages_id'] !=
                                            sellerMultiListingPackageGV[
                                                'packages']['packages_id']) {
                                      print(
                                          'multi-listing already subscribed and bought, and chosen a different package');

                                      await boostIndividualListing(
                                          listingsHousingsId:
                                              data['listings_housings_id'],
                                          usersCustomersPkgsId:
                                              sellerMultiListingPackageGV[
                                                  'users_customers_packages_id']);
                                    }
                                    //============ cases done: for selecting a different package other than multi-listing
                                    //============ cases: for selecting a multi-listing package
                                    else if (sellerMultiListingPackageGV
                                            .isNotEmpty &&
                                        selectedBoostingItem?['packages_id'] ==
                                            sellerMultiListingPackageGV[
                                                'packages']['packages_id'] &&
                                        sellerMultiListingPackageGV[
                                                'payment_status'] ==
                                            'Unpaid') {
                                      print(
                                          'multi-listing already subscribed, not bought but again choose multi-listing package');
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(
                                                    buyTheProduct: false,
                                                    buyTheBoosting: true,
                                                    listingHousingId: data[
                                                        'listings_housings_id'],
                                                    selectedPackage:
                                                        sellerMultiListingPackageGV[
                                                            'packages'],
                                                    userCustomerPackagesId:
                                                        sellerMultiListingPackageGV[
                                                            'users_customers_packages_id'],
                                                  )),
                                          (route) => false);
                                    } else if (sellerMultiListingPackageGV
                                            .isNotEmpty &&
                                        selectedBoostingItem?['packages_id'] ==
                                            sellerMultiListingPackageGV[
                                                'packages']['packages_id'] &&
                                        sellerMultiListingPackageGV[
                                                'payment_status'] ==
                                            'Paid') {
                                      print(
                                          'multi-listing already subscribed and bought but again chosen multi-listing package');
                                      await boostIndividualListing(
                                          listingsHousingsId:
                                              data['listings_housings_id'],
                                          usersCustomersPkgsId:
                                              sellerMultiListingPackageGV[
                                                  'users_customers_packages_id']);
                                    }
                                    // ================inner if-else done==================
                                  } else if (selectedBoostingItem?[
                                          'packages_id'] ==
                                      null) {
                                    // ignore: use_build_context_synchronously
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
                                  } else {}
                                } else if (data['featured'] == 'Yes') {
                                  // ignore: use_build_context_synchronously
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
                                } else {}
                              }
                              if (status == 'error') {
                                String message = decodedResponse?['message'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(message: message));
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
