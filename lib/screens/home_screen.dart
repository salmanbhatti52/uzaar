import 'dart:convert';

import 'package:Uzaar/screens/BusinessDetailPages/housing_details_page.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/featured_housing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';

import 'package:Uzaar/widgets/search_field.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/Buttons.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/alert_dialog_reusable.dart';
import '../widgets/business_type_button.dart';
import 'BusinessDetailPages/product_details_page.dart';
import 'BusinessDetailPages/service_details_page.dart';
import 'chat_list_screen.dart';
import 'notifications_screen.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  late Set<ReportReason> selectedReasons = {};
  late SharedPreferences preferences;
  bool showSpinner = false;
  dynamic featuredProducts;
  dynamic featuredServices;
  dynamic featuredHousings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    featuredProducts = featuredProductsGV;
    featuredServices = featuredServicesGV;
    featuredHousings = featuredHousingGV;
    setState(() {});
    await getUserData();
    getListingTypes();
    getProductListingsCategories();
    getServiceListingsCategories();
    getHousingListingsCategories();
    getFeaturedProducts();
    getFeaturedServices();
    getFeaturedHousings();
  }

  getUserData() async {
    preferences = await SharedPreferences.getInstance();
    loginAsGuestGV = preferences.getBool('loginAsGuest')!;
    print('Login as Guest Status: $loginAsGuestGV');

    if (loginAsGuestGV == false) {
      int? userId = preferences.getInt('user_id');
      String? firstName = preferences.getString('first_name');
      String? lastName = preferences.getString('last_name');
      String? email = preferences.getString('email');
      String? profilePic = preferences.getString('profile_pic');
      String? phoneNumber = preferences.getString('phone_number');
      String? address = preferences.getString('address');
      String? latitude = preferences.getString('latitude');
      String? longitude = preferences.getString('longitude');
      bool? orderStatus = preferences.getBool('order_status');
      bool? reviewsToggleVal = preferences.getBool('reviews_status');
      bool? offersToggleVal = preferences.getBool('offers_status');

      userDataGV = {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'profilePic': profilePic,
        'phoneNumber': phoneNumber,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'orderStatus': orderStatus,
        'reviewsToggleVal': reviewsToggleVal,
        'offersToggleVal': offersToggleVal
      };

      print(userDataGV);
    }
    if (loginAsGuestGV == true) {
      int? userId = preferences.getInt('user_id');
      String? guestUserName = preferences.getString('guest_user_name');
      String? guestUserEmail = preferences.getString('guest_user_email');

      userDataGV = {
        'userId': userId,
        'guestUserName': guestUserName,
        'guestUserEmail': guestUserEmail,
      };

      print(userDataGV);
    }
  }

  getListingTypes() async {
    Response response = await sendGetRequest('get_listings_types');

    print(response.statusCode);
    print(response.body);
    listingTypesGV = jsonDecode(response.body);
    if (mounted) {
      setState(() {
        if (selectedListingTypeGV.isEmpty) {
          selectedListingTypeGV = listingTypesGV?['data'][0]['name'];
        }
      });
    }
  }

  getProductListingsCategories() async {
    Response response =
        await sendPostRequest(action: 'get_listings_categories', data: {
      'listings_types': 'listings_products'
      // "listings_products" or "listings_services" or "listings_housings"
    });

    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      productListingCategoriesGV = decodedResponse['data'];
      print('productListingCategoriesGV: $productListingCategoriesGV');
      // if (listingSelectedCategoryGV.isEmpty) {
      //   listingSelectedCategoryGV = productListingCategoriesGV[0]['name'];
      // }

      // fetching and storing data of category Names in  productListingCategoriesNames
      if (productListingCategoriesNamesGV.isEmpty) {
        for (int i = 0; i < productListingCategoriesGV.length; i++) {
          print(productListingCategoriesGV[i]['name']);
          productListingCategoriesNamesGV
              .add(productListingCategoriesGV[i]['name']);
        }
        print('categories: $productListingCategoriesNamesGV');
      }
      // done
    }
    if (mounted) {
      setState(() {});
    }
  }

  getServiceListingsCategories() async {
    Response response =
        await sendPostRequest(action: 'get_listings_categories', data: {
      'listings_types': 'listings_services'
      // "listings_products" or "listings_services" or "listings_housings"
    });

    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      serviceListingCategoriesGV = decodedResponse['data'];
      print('serviceListingCategoriesGV: $serviceListingCategoriesGV');

      // fetching and storing data of category Names in  serviceListingCategoriesNames
      if (serviceListingCategoriesNamesGV.isEmpty) {
        for (int i = 0; i < serviceListingCategoriesGV.length; i++) {
          print(serviceListingCategoriesGV[i]['name']);
          serviceListingCategoriesNamesGV
              .add(serviceListingCategoriesGV[i]['name']);
        }
        print('categories: $serviceListingCategoriesNamesGV');
      }
      // done
    }
    if (mounted) {
      setState(() {});
    }
  }

  getHousingListingsCategories() async {
    Response response =
        await sendPostRequest(action: 'get_listings_categories', data: {
      'listings_types': 'listings_housings'
      // "listings_products" or "listings_services" or "listings_housings"
    });

    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      housingListingCategoriesGV = decodedResponse['data'];
      print('housingListingCategoriesGV: $housingListingCategoriesGV');

      // fetching and storing data of category Names in  housingListingCategoriesNames
      if (housingListingCategoriesNamesGV.isEmpty) {
        for (int i = 0; i < housingListingCategoriesGV.length; i++) {
          print(housingListingCategoriesGV[i]['name']);
          housingListingCategoriesNamesGV
              .add(housingListingCategoriesGV[i]['name']);
        }
        print('categories: $housingListingCategoriesNamesGV');
      }
      // done
    }
    if (mounted) {
      setState(() {});
    }
  }

  getFeaturedProducts() async {
    Response response =
        await sendPostRequest(action: 'get_featured_listings_products', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    featuredProductsGV = decodedResponse['data'];
    featuredProducts = featuredProductsGV;
    print('featuredProductsGV: $featuredProductsGV');
    if (mounted) {
      setState(() {});
    }
  }

  getFeaturedServices() async {
    Response response =
        await sendPostRequest(action: 'get_featured_listings_services', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    featuredServicesGV = decodedResponse['data'];
    featuredServices = featuredServicesGV;
    print('featuredServicesGV: $featuredServicesGV');
    if (mounted) {
      setState(() {});
    }
  }

  getFeaturedHousings() async {
    Response response =
        await sendPostRequest(action: 'get_featured_listings_housings', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    featuredHousingGV = decodedResponse['data'];
    featuredHousings = featuredHousingGV;
    print('featuredHousingGV: $featuredHousingGV');
    if (mounted) {
      setState(() {});
    }
  }

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedListingTypeGV = listingTypesGV?['data'][0]['name'];
    // listingSelectedCategoryGV = productListingCategoriesGV[0]['name'];
    listingSelectedCategoryGV = '';
  }

  int selectedCategory = 1;

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
                  // Column(
                  //   children: [
                  //     Text(
                  //       'Good Morning!',
                  //       style: kAppBarTitleStyle,
                  //     ),
                  //     Text(
                  //       'John',
                  //       style: kAppBarTitleStyle,
                  //     ),
                  //   ],
                  // ),
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
            'Home',
            style: kAppBarTitleStyle,
          ),
        ),
        drawer: DrawerWidget(
          buildContext: context,
        ),
        backgroundColor: Colors.white,
        body: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: primaryBlue,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'John',
                  //         style: GoogleFonts.outfit(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           color: black,
                  //         ),
                  //       )
                  //     ],
                  //     text: 'Good Morning!   ',
                  //     style: GoogleFonts.outfit(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //       color: black,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SearchField(searchController: searchController),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'What are you looking for?',
                    style: kBodySubHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listingTypesGV != null
                        ? List.generate(
                            listingTypesGV?['data'].length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedListingTypeGV =
                                      listingTypesGV?['data'][index]['name'];

                                  // to get all data when a listing type selected and clear filtered data
                                  listingSelectedCategoryGV = '';
                                  featuredProducts = featuredProductsGV;
                                  featuredServices = featuredServicesGV;
                                  featuredHousings = featuredHousingGV;
                                });
                                print(
                                    'selectedListingTypeGV: $selectedListingTypeGV');
                              },
                              child: BusinessTypeButton(
                                  margin:
                                      index < listingTypesGV?['data'].length - 1
                                          ? EdgeInsets.only(right: 10)
                                          : null,
                                  businessName: listingTypesGV?['data'][index]
                                      ['name'],
                                  gradient: selectedListingTypeGV ==
                                          listingTypesGV?['data'][index]['name']
                                      ? gradient
                                      : null,
                                  buttonBackground: selectedListingTypeGV !=
                                          listingTypesGV?['data'][index]['name']
                                      ? grey.withOpacity(0.3)
                                      : null,
                                  textColor: selectedListingTypeGV ==
                                          listingTypesGV?['data'][index]['name']
                                      ? white
                                      : grey),
                            ),
                          )
                        : List.generate(
                            3,
                            (index) => Shimmer.fromColors(
                                child: BusinessTypeButton(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    businessName: '',
                                    gradient: null,
                                    buttonBackground: grey.withOpacity(0.3),
                                    textColor: grey),
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!),
                          ),
                  ),

                  SizedBox(
                    height: 30.h,
                  ),

                  SizedBox(
                    height: 98,
                    child: selectedListingTypeGV == 'Products' &&
                            productListingCategoriesGV != null
                        ? ListView.builder(
                            itemCount: productListingCategoriesGV.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  listingSelectedCategoryGV =
                                      productListingCategoriesGV[index]['name'];
                                  List<dynamic> filteredProducts = [];
                                  for (var product in featuredProductsGV) {
                                    if (product['listings_categories']['name']
                                        .contains(listingSelectedCategoryGV)) {
                                      filteredProducts.add(product);
                                    }
                                  }
                                  featuredProducts = filteredProducts;
                                  setState(() {});
                                },
                                child: BusinessListTile(
                                  selectedCategory: listingSelectedCategoryGV ==
                                          productListingCategoriesGV[index]
                                              ['name']
                                      ? true
                                      : false,
                                  businessTileName:
                                      productListingCategoriesGV[index]['name'],
                                  businessTileImageName:
                                      productListingCategoriesGV[index]
                                          ['image'],
                                ),
                              );
                            },
                          )
                        : selectedListingTypeGV == 'Services' &&
                                serviceListingCategoriesGV != null
                            ? ListView.builder(
                                itemCount: serviceListingCategoriesGV.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      listingSelectedCategoryGV =
                                          serviceListingCategoriesGV[index]
                                              ['name'];
                                      List<dynamic> filteredServices = [];
                                      for (var service in featuredServicesGV) {
                                        if (service['listings_categories']
                                                ['name']
                                            .contains(
                                                listingSelectedCategoryGV)) {
                                          filteredServices.add(service);
                                        }
                                      }
                                      featuredServices = filteredServices;
                                      setState(() {});
                                    },
                                    child: BusinessListTile(
                                        selectedCategory:
                                            listingSelectedCategoryGV ==
                                                    serviceListingCategoriesGV[
                                                        index]['name']
                                                ? true
                                                : false,
                                        businessTileName:
                                            serviceListingCategoriesGV[index]
                                                ['name'],
                                        businessTileImageName:
                                            serviceListingCategoriesGV[index]
                                                ['image']),
                                  );
                                },
                              )
                            : selectedListingTypeGV == 'Housings' &&
                                    housingListingCategoriesGV != null
                                ? ListView.builder(
                                    itemCount:
                                        housingListingCategoriesGV.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          listingSelectedCategoryGV =
                                              housingListingCategoriesGV[index]
                                                  ['name'];
                                          List<dynamic> filteredHousings = [];
                                          if (featuredHousingGV != null) {
                                            for (var house
                                                in featuredHousingGV) {
                                              if (house['listings_categories']
                                                      ['name']
                                                  .contains(
                                                      listingSelectedCategoryGV)) {
                                                filteredHousings.add(house);
                                              }
                                            }
                                            featuredHousings = filteredHousings;
                                          }

                                          setState(() {});
                                        },
                                        child: BusinessListTile(
                                            selectedCategory:
                                                listingSelectedCategoryGV ==
                                                        housingListingCategoriesGV[
                                                            index]['name']
                                                    ? true
                                                    : false,
                                            businessTileName:
                                                housingListingCategoriesGV[
                                                    index]['name'],
                                            businessTileImageName:
                                                housingListingCategoriesGV[
                                                    index]['image']),
                                      );
                                    },
                                  )
                                : Shimmer.fromColors(
                                    child: ListView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                // margin: EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        grey.withOpacity(0.3),
                                                    shape: BoxShape.circle),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: 10,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color:
                                                        grey.withOpacity(0.3),
                                                    shape: BoxShape.rectangle),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    baseColor: Colors.grey[500]!,
                                    highlightColor: Colors.grey[100]!),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  selectedListingTypeGV == 'Products'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Featured Products',
                              style: kBodyHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              decoration: BoxDecoration(color: Colors.white),
                              height: 187,
                              child: featuredProducts != null
                                  ? ListView.builder(
                                      itemBuilder: (context, index) {
                                        return FeaturedProductsWidget(
                                          productCondition:
                                              featuredProducts[index]
                                                  ['condition'],
                                          image: imgBaseUrl +
                                              featuredProducts[index]
                                                      ['listings_images'][0]
                                                  ['image'],
                                          productCategory:
                                              featuredProducts[index]
                                                      ['listings_categories']
                                                  ['name'],
                                          productName: featuredProducts[index]
                                              ['name'],
                                          productLocation: 'California',
                                          productPrice: featuredProducts[index]
                                              ['price'],
                                          onImageTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsPage(
                                                  productData:
                                                      featuredProducts[index],
                                                ),
                                              ),
                                            );
                                          },
                                          onOptionTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter
                                                        stateSetterObject) {
                                                  return AlertDialogReusable(
                                                    description:
                                                        'Select any reason to report. We will show you less listings like this next time.',
                                                    title: 'Report Listing',
                                                    itemsList: [
                                                      SizedBox(
                                                        height: 35,
                                                        child: ListTile(
                                                          title: Text(
                                                            'Not Interested',
                                                            style:
                                                                kTextFieldInputStyle,
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              stateSetterObject(
                                                                  () {
                                                                handleOptionSelection(
                                                                    ReportReason
                                                                        .notInterested);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(selectedReasons
                                                                    .contains(
                                                                        ReportReason
                                                                            .notInterested)
                                                                ? 'assets/selected_check.svg'
                                                                : 'assets/default_check.svg'),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                        child: ListTile(
                                                          title: Text(
                                                            'Not Authentic',
                                                            style:
                                                                kTextFieldInputStyle,
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              stateSetterObject(
                                                                  () {
                                                                handleOptionSelection(
                                                                    ReportReason
                                                                        .notAuthentic);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(selectedReasons
                                                                    .contains(
                                                                        ReportReason
                                                                            .notAuthentic)
                                                                ? 'assets/selected_check.svg'
                                                                : 'assets/default_check.svg'),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                        child: ListTile(
                                                          title: Text(
                                                            'Inappropriate',
                                                            style:
                                                                kTextFieldInputStyle,
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              stateSetterObject(
                                                                  () {
                                                                handleOptionSelection(
                                                                    ReportReason
                                                                        .inappropriate);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(selectedReasons
                                                                    .contains(
                                                                        ReportReason
                                                                            .inappropriate)
                                                                ? 'assets/selected_check.svg'
                                                                : 'assets/default_check.svg'),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                        child: ListTile(
                                                          title: Text(
                                                            'Violent or prohibited content',
                                                            style:
                                                                kTextFieldInputStyle,
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              stateSetterObject(
                                                                  () {
                                                                handleOptionSelection(
                                                                    ReportReason
                                                                        .violent);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(selectedReasons
                                                                    .contains(
                                                                        ReportReason
                                                                            .violent)
                                                                ? 'assets/selected_check.svg'
                                                                : 'assets/default_check.svg'),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                        child: ListTile(
                                                          title: Text(
                                                            'Other',
                                                            style:
                                                                kTextFieldInputStyle,
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              stateSetterObject(
                                                                  () {
                                                                handleOptionSelection(
                                                                    ReportReason
                                                                        .other);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(selectedReasons
                                                                    .contains(
                                                                        ReportReason
                                                                            .other)
                                                                ? 'assets/selected_check.svg'
                                                                : 'assets/default_check.svg'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    button: primaryButton(
                                                        context: context,
                                                        buttonText: 'Send',
                                                        onTap: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        showLoader: false),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      itemCount: featuredProducts.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                    )
                                  : Shimmer.fromColors(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return const FeaturedProductsDummy();
                                        },
                                        itemCount: 6,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                      ),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )
                      : SizedBox(),

                  selectedListingTypeGV == 'Services'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Featured Services',
                              style: kBodyHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 187,
                              child: featuredServices != null
                                  ? ListView.builder(
                                      itemBuilder: (context, index) {
                                        return FeaturedServicesWidget(
                                          image: imgBaseUrl +
                                              featuredServices[index]
                                                      ['listings_images'][0]
                                                  ['image'],
                                          serviceCategory:
                                              featuredServices[index]
                                                      ['listings_categories']
                                                  ['name'],
                                          serviceName: featuredServices[index]
                                              ['name'],
                                          serviceLocation:
                                              featuredServices[index]
                                                  ['location'],
                                          servicePrice: featuredServices[index]
                                              ['price'],
                                          onImageTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceDetailsPage(
                                                serviceData:
                                                    featuredServices[index],
                                              ),
                                            ),
                                          ),
                                          onOptionTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter
                                                        stateSetterObject) {
                                                  return AlertDialogReusable(
                                                      description:
                                                          'Select any reason to report. We will show you less listings like this next time.',
                                                      title: 'Report Listing',
                                                      itemsList: [
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Not Interested',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .notInterested);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .notInterested)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Not Authentic',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .notAuthentic);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .notAuthentic)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Inappropriate',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .inappropriate);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .inappropriate)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Violent or prohibited content',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .violent);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .violent)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Other',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .other);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .other)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      button: primaryButton(
                                                          context: context,
                                                          buttonText: 'Send',
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          showLoader: false));
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      itemCount: featuredServices.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                    )
                                  : Shimmer.fromColors(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return const FeaturedProductsDummy();
                                        },
                                        itemCount: 6,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                      ),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )
                      : SizedBox(),

                  selectedListingTypeGV == 'Housings'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Featured Housing',
                              style: kBodyHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 206,
                              child: featuredHousings != null
                                  ? ListView.builder(
                                      itemBuilder: (context, index) {
                                        return FeaturedHousingWidget(
                                          furnishedStatus:
                                              featuredHousings[index]
                                                          ['furnished'] ==
                                                      'Yes'
                                                  ? 'Furnished'
                                                  : 'Not Furnished',
                                          image: imgBaseUrl +
                                              featuredHousings[index]
                                                      ['listings_images'][0]
                                                  ['image'],
                                          housingCategory:
                                              featuredHousings[index]
                                                      ['listings_categories']
                                                  ['name'],
                                          housingName: featuredHousings[index]
                                              ['name'],
                                          housingLocation:
                                              featuredHousings[index]
                                                  ['location'],
                                          housingPrice: featuredHousings[index]
                                              ['price'],
                                          area: featuredHousings[index]['area'],
                                          bedrooms: featuredHousings[index]
                                              ['bedroom'],
                                          bathrooms: featuredHousings[index]
                                              ['bathroom'],
                                          onImageTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  HousingDetailsPage(
                                                houseData:
                                                    featuredHousings[index],
                                              ),
                                            ));
                                          },
                                          onOptionTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter
                                                        stateSetterObject) {
                                                  return AlertDialogReusable(
                                                      description:
                                                          'Select any reason to report. We will show you less listings like this next time.',
                                                      title: 'Report Listing',
                                                      itemsList: [
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Not Interested',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .notInterested);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .notInterested)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Not Authentic',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .notAuthentic);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .notAuthentic)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Inappropriate',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .inappropriate);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .inappropriate)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Violent or prohibited content',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .violent);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .violent)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                          child: ListTile(
                                                            title: Text(
                                                              'Other',
                                                              style:
                                                                  kTextFieldInputStyle,
                                                            ),
                                                            leading:
                                                                GestureDetector(
                                                              onTap: () {
                                                                stateSetterObject(
                                                                    () {
                                                                  handleOptionSelection(
                                                                      ReportReason
                                                                          .other);
                                                                });
                                                              },
                                                              child: SvgPicture.asset(selectedReasons
                                                                      .contains(
                                                                          ReportReason
                                                                              .other)
                                                                  ? 'assets/selected_check.svg'
                                                                  : 'assets/default_check.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      button: primaryButton(
                                                          context: context,
                                                          buttonText: 'Send',
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          showLoader: false));
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      itemCount: featuredHousings.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                    )
                                  : Shimmer.fromColors(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return const FeaturedProductsDummy();
                                        },
                                        itemCount: 6,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                      ),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BusinessListTile extends StatelessWidget {
  const BusinessListTile({
    required this.businessTileName,
    required this.businessTileImageName,
    required this.selectedCategory,
    super.key,
  });
  final String businessTileName;
  final String businessTileImageName;
  final bool selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: f5f5f5,
                  border: selectedCategory
                      ? Border.all(
                          color: primaryBlue,
                          width: 1,
                          style: BorderStyle.solid)
                      : null),
              child: Image.network(
                imgBaseUrl + businessTileImageName,
              ),
            ),
            Center(
              child: Text(
                businessTileName,
                style: kBodyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
