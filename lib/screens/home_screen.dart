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
  late String selectedListingType;
  bool showSpinner = false;
  dynamic listingTypes;
  dynamic featuredProducts;
  dynamic featuredServices;
  dynamic featuredHousing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  init() async {
    if (listingTypesGV != null) {
      selectedListingType = listingTypesGV?['data'][0]['name'];
    } else {
      selectedListingType = '';
    }
    await getUserData();
    print('productListingCategoriesGV: $productListingCategoriesGV');
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
        selectedListingType = listingTypesGV?['data'][0]['name'];
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

      // fetching and storing data of category Names in  productListingCategoriesNames
      if (productListingCategoriesNames.isEmpty) {
        for (int i = 0; i < productListingCategoriesGV.length; i++) {
          print(productListingCategoriesGV[i]['name']);
          productListingCategoriesNames
              .add(productListingCategoriesGV[i]['name']);
        }
        print('categories: $productListingCategoriesNames');
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
      if (serviceListingCategoriesNames.isEmpty) {
        for (int i = 0; i < serviceListingCategoriesGV.length; i++) {
          print(serviceListingCategoriesGV[i]['name']);
          serviceListingCategoriesNames
              .add(serviceListingCategoriesGV[i]['name']);
        }
        print('categories: $serviceListingCategoriesNames');
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
      if (housingListingCategoriesNames.isEmpty) {
        for (int i = 0; i < housingListingCategoriesGV.length; i++) {
          print(housingListingCategoriesGV[i]['name']);
          housingListingCategoriesNames
              .add(housingListingCategoriesGV[i]['name']);
        }
        print('categories: $housingListingCategoriesNames');
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
    print('featuredServicesGV: $featuredServicesGV');
    setState(() {});
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
                                  selectedListingType =
                                      listingTypesGV?['data'][index]['name'];
                                });
                                print(
                                    'selectedListingType: $selectedListingType');
                              },
                              child: BusinessTypeButton(
                                  margin:
                                      index < listingTypesGV?['data'].length - 1
                                          ? EdgeInsets.only(right: 10)
                                          : null,
                                  businessName: listingTypesGV?['data'][index]
                                      ['name'],
                                  gradient: selectedListingType ==
                                          listingTypesGV?['data'][index]['name']
                                      ? gradient
                                      : null,
                                  buttonBackground: selectedListingType !=
                                          listingTypesGV?['data'][index]['name']
                                      ? grey.withOpacity(0.3)
                                      : null,
                                  textColor: selectedListingType ==
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
                    child: selectedListingType == 'Products' &&
                            productListingCategoriesGV != null
                        ? ListView.builder(
                            itemCount: productListingCategoriesGV.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return BusinessListTile(
                                businessTileName:
                                    productListingCategoriesGV[index]['name'],
                                businessTileImageName:
                                    productListingCategoriesGV[index]['image'],
                                // businessTileName:
                                //     productCategoryModel[index].catName,
                                // businessTileImageName:
                                //     productCategoryModel[index].image,
                              );
                            },
                          )
                        : selectedListingType == 'Services' &&
                                serviceListingCategoriesGV != null
                            ? ListView.builder(
                                itemCount: serviceListingCategoriesGV.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return BusinessListTile(
                                      businessTileName:
                                          serviceListingCategoriesGV[index]
                                              ['name'],
                                      businessTileImageName:
                                          serviceListingCategoriesGV[index]
                                              ['image']);
                                },
                              )
                            : selectedListingType == 'Housings' &&
                                    housingListingCategoriesGV != null
                                ? ListView.builder(
                                    itemCount:
                                        housingListingCategoriesGV.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return BusinessListTile(
                                          businessTileName:
                                              housingListingCategoriesGV[index]
                                                  ['name'],
                                          businessTileImageName:
                                              housingListingCategoriesGV[index]
                                                  ['image']);
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
                    child: featuredProductsGV != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return FeaturedProductsWidget(
                                productCondition: featuredProductsGV[index]
                                    ['condition'],
                                image: imgBaseUrl +
                                    featuredProductsGV[index]['listings_images']
                                        [0]['image'],
                                productCategory: featuredProductsGV[index]
                                    ['listings_categories']['name'],
                                productName: featuredProductsGV[index]['name'],
                                productLocation: 'California',
                                productPrice: featuredProductsGV[index]
                                    ['price'],
                                onImageTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        productData: featuredProductsGV[index],
                                      ),
                                    ),
                                  );
                                },
                                onOptionTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter stateSetterObject) {
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
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .notInterested);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(selectedReasons
                                                          .contains(ReportReason
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
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .notAuthentic);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
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
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .inappropriate);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(selectedReasons
                                                          .contains(ReportReason
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
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason.violent);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
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
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason.other);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
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
                                                  Navigator.of(context).pop(),
                                              showLoader: false),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: featuredProductsGV.length,
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
                  Text(
                    'Featured Services',
                    style: kBodyHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 187,
                    child: featuredServicesGV != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return FeaturedServicesWidget(
                                image: imgBaseUrl +
                                    featuredServicesGV[index]['listings_images']
                                        [0]['image'],
                                serviceCategory: featuredServicesGV[index]
                                    ['listings_categories']['name'],
                                serviceName: featuredServicesGV[index]['name'],
                                serviceLocation: featuredServicesGV[index]
                                    ['location'],
                                servicePrice: featuredServicesGV[index]
                                    ['price'],
                                onImageTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ServiceDetailsPage(
                                      serviceData: featuredServicesGV[index],
                                    ),
                                  ),
                                ),
                                onOptionTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter stateSetterObject) {
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .notInterested);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .notAuthentic);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .inappropriate);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .violent);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason.other);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons
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
                                                    Navigator.of(context).pop(),
                                                showLoader: false));
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: featuredServicesGV.length,
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
                  Text(
                    'Featured Housing',
                    style: kBodyHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 206,
                    child: featuredHousingGV != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return FeaturedHousingWidget(
                                furnishedStatus: featuredHousingGV[index]
                                            ['furnished'] ==
                                        'Yes'
                                    ? 'Furnished'
                                    : 'Not Furnished',
                                image: imgBaseUrl +
                                    featuredHousingGV[index]['listings_images']
                                        [0]['image'],
                                housingCategory: featuredHousingGV[index]
                                    ['listings_categories']['name'],
                                housingName: featuredHousingGV[index]['name'],
                                housingLocation: featuredHousingGV[index]
                                    ['location'],
                                housingPrice: featuredHousingGV[index]['price'],
                                area: featuredHousingGV[index]['area'],
                                bedrooms: featuredHousingGV[index]['bedroom'],
                                bathrooms: featuredHousingGV[index]['bathroom'],
                                onImageTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HousingDetailsPage(
                                      houseData: featuredHousingGV[index],
                                    ),
                                  ));
                                },
                                onOptionTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter stateSetterObject) {
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .notInterested);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .notAuthentic);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .inappropriate);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason
                                                                .violent);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons.contains(
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
                                                    style: kTextFieldInputStyle,
                                                  ),
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        handleOptionSelection(
                                                            ReportReason.other);
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedReasons
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
                                                    Navigator.of(context).pop(),
                                                showLoader: false));
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: featuredHousingGV.length,
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
    super.key,
  });
  final String businessTileName;
  final String businessTileImageName;

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
              ),
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
