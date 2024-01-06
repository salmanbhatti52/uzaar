import 'dart:convert';

import 'package:Uzaar/screens/BusinessDetailPages/service_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/featured_products_widget.dart';
import '../../widgets/rounded_small_dropdown_menu.dart';
import '../../widgets/search_field.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class ExploreServicesScreen extends StatefulWidget {
  const ExploreServicesScreen({super.key});

  @override
  State<ExploreServicesScreen> createState() => _ExploreServicesScreenState();
}

class _ExploreServicesScreenState extends State<ExploreServicesScreen> {
  final searchController = TextEditingController();
  late Set<ReportReason> selectedReasons = {};
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedPrice;
  String? selectedLocation;
  List<dynamic> allListingsServices = [...allListingsServicesGV];
  String allListingServicesErrMsg = '';
  // List<String> categories = [...serviceListingCategoriesNamesGV];
  dynamic selectedPriceRange;
  List subCategories = [];
  final List<String> locations = [
    'Multan',
    'Lahore',
    'Karachi',
  ];

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  getAllServices() async {
    Response response = await sendGetRequest('get_all_listings_services');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    allListingsServicesGV = [];
    if (status == 'success') {
      allListingsServicesGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          allListingsServices = allListingsServicesGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (allListingsServices.isEmpty) {
            allListingServicesErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('allListingsServices: $allListingsServices');
  }

  searchServicesByName(String value) {
    print(value);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        print(value);
        List<dynamic> filteredItems = [];

        for (var service in allListingsServicesGV) {
          String serviceName = service['name'];
          serviceName = serviceName.toLowerCase();
          if (serviceName.contains(value.toLowerCase())) {
            filteredItems.add(service);
          }
        }
        if (mounted) {
          setState(() {
            allListingsServices = filteredItems;
            if (allListingsServices.isEmpty) {
              allListingServicesErrMsg = 'No listing found.';
            } else {
              allListingServicesErrMsg = '';
            }
          });
        }
      },
    );
  }

  filterServices() {
    dynamic serviceCategoryName;
    dynamic serviceLocation;
    double servicePrice;
    allListingsServices = allListingsServicesGV;
    List<dynamic> filteredServices = [];
    print('selectedPriceRange: $selectedPriceRange');
    print('selectedCategory: $selectedCategory');
    print('selectedLocation: $selectedLocation');

    for (var service in allListingsServices) {
      serviceCategoryName = service['listings_categories']['name'];
      servicePrice = double.parse(service['price']);
      serviceLocation = service['location'];
      if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null) {
        if (serviceCategoryName.contains(selectedCategory) &&
            (servicePrice >= selectedPriceRange['range_from'] &&
                servicePrice <= selectedPriceRange['range_to']) &&
            serviceLocation.contains(selectedLocation)) {
          filteredServices.add(service);
        }
      } else if (selectedCategory != null && selectedPriceRange != null) {
        if (serviceCategoryName.contains(selectedCategory) &&
            (servicePrice >= selectedPriceRange['range_from'] &&
                servicePrice <= selectedPriceRange['range_to'])) {
          filteredServices.add(service);
        }
      } else if (selectedCategory != null && selectedLocation != null) {
        if (serviceCategoryName.contains(selectedCategory) &&
            serviceLocation.contains(selectedLocation)) {
          filteredServices.add(service);
        }
      } else if (selectedPriceRange != null && selectedLocation != null) {
        if ((servicePrice >= selectedPriceRange['range_from'] &&
                servicePrice <= selectedPriceRange['range_to']) &&
            serviceLocation.contains(selectedLocation)) {
          filteredServices.add(service);
        }
      } else if (selectedCategory != null) {
        if (serviceCategoryName.contains(selectedCategory)) {
          filteredServices.add(service);
        }
      } else if (selectedPriceRange != null) {
        if (servicePrice >= selectedPriceRange['range_from'] &&
            servicePrice <= selectedPriceRange['range_to']) {
          filteredServices.add(service);
        }
      } else if (selectedLocation != null) {
        if (serviceLocation.contains(selectedLocation)) {
          filteredServices.add(service);
        }
      } else {}
    }

    setState(() {
      allListingsServices = filteredServices;
      if (allListingsServices.isEmpty) {
        allListingServicesErrMsg = 'No listing found.';
      } else {
        allListingServicesErrMsg = '';
      }
    });
  }

  getServicesPriceRanges() async {
    Response response = await sendPostRequest(
        action: 'listings_types_prices_ranges',
        data: {'listings_types_id': '2'});
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    servicesPriceRangesGV = decodedResponse['data'];
    if (mounted) {
      setState(() {});
    }
  }

  getCategorySubCategories({required int categoryId}) async {
    subCategories = [];
    selectedSubCategory = null;
    selectedLocation = null;
    selectedPrice = null;
    selectedPriceRange = null;
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
        }
      });
    }
    print(subCategories);
  }

  init() async {
    getAllServices();
    getServicesPriceRanges();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: SearchField(
                  onChanged: (value) {
                    setState(() {
                      selectedPrice = null;
                      selectedCategory = null;
                      allListingsServices = allListingsServicesGV;
                    });
                    searchServicesByName(value.trim());
                  },
                  searchController: searchController)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: servicesPriceRangesGV.isNotEmpty
                  ? Row(
                      children: [
                        RoundedSmallDropdownMenu(
                          width: 170,
                          leadingIconName: selectedCategory != null
                              ? 'cat-selected'
                              : 'cat-unselected',
                          hintText: 'Category',
                          onSelected: (value) {
                            setState(() {
                              selectedCategory = value['name'];
                            });
                            getCategorySubCategories(
                                categoryId: value['listings_categories_id']);
                            print(value);
                            filterServices();
                          },
                          dropdownMenuEntries: serviceListingCategoriesGV
                              .map(
                                (dynamic value) => DropdownMenuEntry<dynamic>(
                                    value: value, label: value['name']),
                              )
                              .toList(),
                        ),
                        subCategories.isNotEmpty
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  RoundedSmallDropdownMenu(
                                    width: 180,
                                    leadingIconName: selectedSubCategory != null
                                        ? 'cat-selected'
                                        : 'cat-unselected',
                                    hintText: 'Seller Type',
                                    onSelected: (value) async {
                                      setState(() {
                                        selectedSubCategory = value['name'];
                                      });
                                      print(value);
                                      // filterServices();
                                    },
                                    dropdownMenuEntries: subCategories
                                        .map(
                                          (dynamic value) =>
                                              DropdownMenuEntry<dynamic>(
                                                  value: value,
                                                  label: value['name']),
                                        )
                                        .toList(),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: 10.w,
                        ),
                        RoundedSmallDropdownMenu(
                          width: 160,
                          leadingIconName: selectedPrice != null
                              ? 'cat-selected'
                              : 'cat-unselected',
                          hintText: 'Price',
                          onSelected: (value) {
                            setState(() {
                              selectedPrice =
                                  '${value['range_from']} - ${value['range_to']}';
                            });
                            print(selectedPrice);
                            selectedPriceRange = value;
                            filterServices();
                          },
                          dropdownMenuEntries: servicesPriceRangesGV
                              .map(
                                (dynamic value) => DropdownMenuEntry<dynamic>(
                                    value: value,
                                    label:
                                        '${value['range_from']} - ${value['range_to']}'),
                              )
                              .toList(),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        RoundedSmallDropdownMenu(
                          // trailingIconName: 'blue_address_icon',
                          width: 170,
                          leadingIconName: selectedLocation != null
                              ? 'cat-selected'
                              : 'cat-unselected',
                          hintText: 'Location',
                          onSelected: (value) {
                            setState(() {
                              selectedLocation = value;
                            });
                            filterServices();
                          },
                          dropdownMenuEntries: locations
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList(),
                        ),
                      ],
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const Row(
                        children: [
                          RoundedSmallDropdownMenuDummy(),
                          SizedBox(
                            width: 10,
                          ),
                          RoundedSmallDropdownMenuDummy(),
                          SizedBox(
                            width: 10,
                          ),
                          RoundedSmallDropdownMenuDummy(),
                        ],
                      )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'All Services',
              style: kBodyHeadingTextStyle,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.46,
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: primaryBlue,
                child: allListingsServices.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.only(bottom: 33, left: 2),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 185,
                        ),
                        itemCount: allListingsServices.length,
                        itemBuilder: (context, index) {
                          return FeaturedServicesWidget(
                            image: imgBaseUrl +
                                allListingsServices[index]['listings_images'][0]
                                    ['image'],
                            serviceCategory: allListingsServices[index]
                                ['listings_categories']['name'],
                            serviceName: allListingsServices[index]['name'],
                            serviceLocation: allListingsServices[index]
                                ['location'],
                            servicePrice: allListingsServices[index]['price'],
                            onImageTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ServiceDetailsPage(
                                  serviceData: allListingsServices[index],
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
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
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
                                                child: SvgPicture.asset(selectedReasons
                                                        .contains(ReportReason
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
                                                Navigator.of(context).pop(),
                                            showLoader: false));
                                  },
                                ),
                              );
                            },
                          );
                        },
                      )
                    : allListingsServices.isEmpty &&
                            allListingServicesErrMsg.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: GridView.builder(
                              padding:
                                  const EdgeInsets.only(bottom: 33, left: 2),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 187,
                              ),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return const FeaturedProductsDummy();
                              },
                            ))
                        : Center(
                            child: Text(allListingServicesErrMsg),
                          ),
              ))
        ],
      ),
    );
  }
}
