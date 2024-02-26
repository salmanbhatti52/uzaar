import 'dart:convert';

import 'package:uzaar/screens/BusinessDetailPages/housing_details_page.dart';

import 'package:uzaar/services/restService.dart';
import 'package:uzaar/widgets/BottomNaviBar.dart';
import 'package:uzaar/widgets/featured_housing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/featured_products_widget.dart';
import 'package:uzaar/widgets/featured_services_widget.dart';

import 'package:uzaar/widgets/search_field.dart';

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
  List<dynamic> featuredProducts = [...featuredProductsGV];
  List<dynamic> featuredServices = [...featuredServicesGV];
  List<dynamic> featuredHousings = [...featuredHousingGV];
  String featuredProductsErrMsg = '';
  String featuredServicesErrMsg = '';
  String featuredHousingsErrMsg = '';
  int selectedListingType = 1;
  int _tapCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await getUserData();
    isProfileVerified();
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
      String? profilePathUrl = preferences.getString('profile_path_url');
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
        'profilePathUrl': profilePathUrl,
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
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          listingTypesGV = decodedData['data'];
        });
      }
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
    productListingCategoriesGV = [];
    // productListingCategoriesNamesGV = [];
    if (status == 'success') {
      productListingCategoriesGV = decodedResponse['data'];
      print('productListingCategoriesGV: $productListingCategoriesGV');

      // // fetching and storing data of category Names in  productListingCategoriesNames
      // if (productListingCategoriesNamesGV.isEmpty) {
      //   for (int i = 0; i < productListingCategoriesGV.length; i++) {
      //     print(productListingCategoriesGV[i]['name']);
      //     productListingCategoriesNamesGV
      //         .add(productListingCategoriesGV[i]['name']);
      //   }
      //   print('categories: $productListingCategoriesNamesGV');
      // }
      // // done
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
    serviceListingCategoriesGV = [];
    // serviceListingCategoriesNamesGV = [];
    if (status == 'success') {
      serviceListingCategoriesGV = decodedResponse['data'];
      print('serviceListingCategoriesGV: $serviceListingCategoriesGV');

      // // fetching and storing data of category Names in  serviceListingCategoriesNames
      // if (serviceListingCategoriesNamesGV.isEmpty) {
      //   for (int i = 0; i < serviceListingCategoriesGV.length; i++) {
      //     print(serviceListingCategoriesGV[i]['name']);
      //     serviceListingCategoriesNamesGV
      //         .add(serviceListingCategoriesGV[i]['name']);
      //   }
      //   print('categories: $serviceListingCategoriesNamesGV');
      // }
      // // done
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
    housingListingCategoriesGV = [];
    // housingListingCategoriesNamesGV = [];
    if (status == 'success') {
      housingListingCategoriesGV = decodedResponse['data'];
      print('housingListingCategoriesGV: $housingListingCategoriesGV');

      // // fetching and storing data of category Names in  housingListingCategoriesNames
      // if (housingListingCategoriesNamesGV.isEmpty) {
      //   for (int i = 0; i < housingListingCategoriesGV.length; i++) {
      //     print(housingListingCategoriesGV[i]['name']);
      //     housingListingCategoriesNamesGV
      //         .add(housingListingCategoriesGV[i]['name']);
      //   }
      //   print('categories: $housingListingCategoriesNamesGV');
      // }
      // // done
    }
    if (mounted) {
      setState(() {});
    }
  }

  getFeaturedProducts() async {
    Response response = await sendGetRequest('get_featured_listings_products');

    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    featuredProductsGV = [];
    if (status == 'success') {
      featuredProductsGV = decodedResponse['data'];

      if (mounted) {
        setState(() {
          featuredProducts = featuredProductsGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (featuredProducts.isEmpty) {
            featuredProductsErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('featuredProducts: $featuredProducts');
  }

  getFeaturedServices() async {
    Response response = await sendGetRequest('get_featured_listings_services');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    featuredServicesGV = [];
    if (status == 'success') {
      featuredServicesGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          featuredServices = featuredServicesGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (featuredServices.isEmpty) {
            featuredServicesErrMsg = 'No listing found.';
          }
        });
      }
    }
  }

  getFeaturedHousings() async {
    Response response = await sendGetRequest('get_featured_listings_housings');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    featuredHousingGV = [];
    if (status == 'success') {
      featuredHousingGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          featuredHousings = featuredHousingGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (featuredHousings.isEmpty) {
            featuredHousingsErrMsg = 'No listing found.';
          }
        });
      }
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

  searchData(String value) {
    print(value);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        print(value);
        List<dynamic> filteredItems = [];
        if (selectedListingType == listingTypesGV[0]['listings_types_id']) {
          for (var product in featuredProductsGV) {
            String productName = product['name'];
            productName = productName.toLowerCase();
            if (productName.contains(value.toLowerCase())) {
              filteredItems.add(product);
            }
          }
          setState(() {
            featuredProducts = filteredItems;
            if (featuredProducts.isEmpty) {
              featuredProductsErrMsg = 'No listing found.';
            } else {
              featuredProductsErrMsg = '';
            }
          });
        } else if (selectedListingType ==
            listingTypesGV[1]['listings_types_id']) {
          for (var service in featuredServicesGV) {
            String serviceName = service['name'];
            serviceName = serviceName.toLowerCase();
            if (serviceName.contains(value.toLowerCase())) {
              filteredItems.add(service);
            }
          }
          setState(() {
            featuredServices = filteredItems;
            if (featuredServices.isEmpty) {
              featuredServicesErrMsg = 'No listing found.';
            } else {
              featuredServicesErrMsg = '';
            }
          });
        } else if (selectedListingType ==
            listingTypesGV[2]['listings_types_id']) {
          for (var house in featuredHousingGV) {
            String houseName = house['name'];
            houseName = houseName.toLowerCase();
            if (houseName.contains(value.toLowerCase())) {
              filteredItems.add(house);
            }
          }
          setState(() {
            featuredHousings = filteredItems;
            if (featuredHousings.isEmpty) {
              featuredHousingsErrMsg = 'No listing found.';
            } else {
              featuredHousingsErrMsg = '';
            }
          });
        } else {}
      },
    );
  }

  isProfileVerified() async {
    Response response = await sendPostRequest(
        action: 'is_verification_applied',
        data: {"users_customers_id": userDataGV['userId']});
    print('isProfileVerified: ${response.body}');
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];

    if (status == 'success') {
      Map data = decodedResponse['data'];
      profileVerificationStatusGV = data['verification_applied'];
    } else if (status == 'error') {
      profileVerificationStatusGV = '';
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedListingType = listingTypesGV[0]['listings_types_id'];
    listingSelectedCategoryGV = '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _tapCount++;
        print(_tapCount);
        if (_tapCount == 1) {
          // Display toast and pop the navigator after the second tap
          // Fluttertoast.showToast(
          //   msg: "Tap again to exit",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.grey,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        } else if (_tapCount >= 2) {
          // Pop the navigator after the second tap
          SystemNavigator.pop();
        }

        // Increment tap count

        // Do not pop the navigator immediately
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          // key: _scaffoldKey,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: black),
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
                padding: const EdgeInsets.only(right: 20),
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
                          builder: (context) => const MessagesScreen(),
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
                          builder: (context) => const NotificationScreen(),
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
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SearchField(
                      searchController: searchController,
                      onChanged: (value) {
                        searchData(value.trim());
                      },
                    ),
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
                      children: listingTypesGV.isNotEmpty
                          ? List.generate(
                              listingTypesGV.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchController.clear();
                                    selectedListingType = listingTypesGV[index]
                                        ['listings_types_id'];

                                    // to get all data when a listing type selected and clear filtered data
                                    listingSelectedCategoryGV = '';
                                    featuredProducts = featuredProductsGV;
                                    featuredServices = featuredServicesGV;
                                    featuredHousings = featuredHousingGV;
                                  });
                                  print(
                                      'selectedListingType: $selectedListingType');
                                },
                                child: BusinessTypeButton(
                                    margin: index < listingTypesGV.length - 1
                                        ? const EdgeInsets.only(right: 10)
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
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 98,
                      child: selectedListingType == 1 &&
                              productListingCategoriesGV.isNotEmpty
                          ? ListView.builder(
                              itemCount: productListingCategoriesGV.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    listingSelectedCategoryGV =
                                        productListingCategoriesGV[index]
                                            ['name'];
                                    List<dynamic> filteredProducts = [];
                                    for (var product in featuredProductsGV) {
                                      if (product['listings_categories']['name']
                                          .contains(
                                              listingSelectedCategoryGV)) {
                                        filteredProducts.add(product);
                                      }
                                    }
                                    setState(() {
                                      featuredProducts = filteredProducts;
                                      if (filteredProducts.isEmpty) {
                                        featuredProductsErrMsg =
                                            'No listing found.';
                                      } else {
                                        featuredProductsErrMsg = '';
                                      }
                                    });
                                  },
                                  child: BusinessListTile(
                                    selectedCategory:
                                        listingSelectedCategoryGV ==
                                                productListingCategoriesGV[
                                                    index]['name']
                                            ? true
                                            : false,
                                    businessTileName:
                                        productListingCategoriesGV[index]
                                            ['name'],
                                    businessTileImageName:
                                        productListingCategoriesGV[index]
                                            ['image'],
                                  ),
                                );
                              },
                            )
                          : selectedListingType == 2 &&
                                  serviceListingCategoriesGV.isNotEmpty
                              ? ListView.builder(
                                  itemCount: serviceListingCategoriesGV.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        listingSelectedCategoryGV =
                                            serviceListingCategoriesGV[index]
                                                ['name'];
                                        List<dynamic> filteredServices = [];
                                        for (var service
                                            in featuredServicesGV) {
                                          if (service['listings_categories']
                                                  ['name']
                                              .contains(
                                                  listingSelectedCategoryGV)) {
                                            filteredServices.add(service);
                                          }
                                        }
                                        setState(() {
                                          featuredServices = filteredServices;
                                          if (filteredServices.isEmpty) {
                                            featuredServicesErrMsg =
                                                'No listing found.';
                                          } else {
                                            featuredServicesErrMsg = '';
                                          }
                                        });
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
                              : selectedListingType == 3 &&
                                      housingListingCategoriesGV.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          housingListingCategoriesGV.length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            listingSelectedCategoryGV =
                                                housingListingCategoriesGV[
                                                    index]['name'];
                                            List<dynamic> filteredHousings = [];

                                            for (var house
                                                in featuredHousingGV) {
                                              if (house['listings_categories']
                                                      ['name']
                                                  .contains(
                                                      listingSelectedCategoryGV)) {
                                                filteredHousings.add(house);
                                              }
                                            }

                                            setState(() {
                                              featuredHousings =
                                                  filteredHousings;
                                              if (filteredHousings.isEmpty) {
                                                featuredHousingsErrMsg =
                                                    'No listing found.';
                                              } else {
                                                featuredHousingsErrMsg = '';
                                              }
                                            });
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
                                      baseColor: Colors.grey[500]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: ListView.builder(
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
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
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  height: 10,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          grey.withOpacity(0.3),
                                                      shape:
                                                          BoxShape.rectangle),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    selectedListingType == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Featured Products',
                                    style: kBodyHeadingTextStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavBar(
                                          requiredScreenIndex: 1,
                                          requiredListingTypeIndex: 1,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      'View All',
                                      style: kColoredTextStyle,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                height: 180,
                                child: featuredProducts.isNotEmpty
                                    ? ListView.builder(
                                        itemBuilder: (context, index) {
                                          return FeaturedProductsWidget(
                                            sellerProfileVerified:
                                                featuredProducts[index]
                                                        ['users_customers']
                                                    ['badge_verified'],
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
                                            // productLocation: 'California',
                                            productPrice:
                                                featuredProducts[index]
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
                                                  builder: (BuildContext
                                                          context,
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
                                        physics: const BouncingScrollPhysics(),
                                      )
                                    : featuredProducts.isEmpty &&
                                            featuredProductsErrMsg.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return const FeaturedProductsDummy();
                                              },
                                              itemCount: 6,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                            ))
                                        : Center(
                                            child: Text(featuredProductsErrMsg),
                                          ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    selectedListingType == 2
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Featured Services',
                                    style: kBodyHeadingTextStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavBar(
                                          requiredScreenIndex: 1,
                                          requiredListingTypeIndex: 2,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      'View All',
                                      style: kColoredTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 187,
                                child: featuredServices.isNotEmpty
                                    ? ListView.builder(
                                        itemBuilder: (context, index) {
                                          return FeaturedServicesWidget(
                                            sellerProfileVerified:
                                                featuredServices[index]
                                                        ['users_customers']
                                                    ['badge_verified'],
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
                                            servicePrice:
                                                featuredServices[index]
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
                                                  builder: (BuildContext
                                                          context,
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
                                                                            ReportReason.notInterested)
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
                                                                            ReportReason.notAuthentic)
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
                                                                            ReportReason.inappropriate)
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
                                                                            ReportReason.violent)
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
                                                                            ReportReason.other)
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
                                        physics: const BouncingScrollPhysics(),
                                      )
                                    : featuredServices.isEmpty &&
                                            featuredServicesErrMsg.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return const FeaturedProductsDummy();
                                              },
                                              itemCount: 6,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                            ))
                                        : Center(
                                            child: Text(featuredServicesErrMsg),
                                          ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    selectedListingType == 3
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Featured Housing',
                                    style: kBodyHeadingTextStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavBar(
                                          requiredScreenIndex: 1,
                                          requiredListingTypeIndex: 3,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      'View All',
                                      style: kColoredTextStyle,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 206,
                                child: featuredHousings.isNotEmpty
                                    ? ListView.builder(
                                        itemBuilder: (context, index) {
                                          return FeaturedHousingWidget(
                                            sellerProfileVerified:
                                                featuredHousings[index]
                                                        ['users_customers']
                                                    ['badge_verified'],
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
                                            housingPrice:
                                                featuredHousings[index]
                                                    ['price'],
                                            area: featuredHousings[index]
                                                ['area'],
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
                                                  builder: (BuildContext
                                                          context,
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
                                                                            ReportReason.notInterested)
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
                                                                            ReportReason.notAuthentic)
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
                                                                            ReportReason.inappropriate)
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
                                                                            ReportReason.violent)
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
                                                                            ReportReason.other)
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
                                        physics: const BouncingScrollPhysics(),
                                      )
                                    : featuredHousings.isEmpty &&
                                            featuredHousingsErrMsg.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return const FeaturedProductsDummy();
                                              },
                                              itemCount: 6,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                            ))
                                        : Center(
                                            child: Text(featuredHousingsErrMsg),
                                          ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
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
      margin: const EdgeInsets.only(right: 7),
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
