import 'dart:convert';

import 'package:Uzaar/screens/BusinessDetailPages/housing_details_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Uzaar/utils/colors.dart';

import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/featured_housing_widget.dart';
import '../../widgets/featured_products_widget.dart';
import '../../widgets/rounded_small_dropdown_menu.dart';
import '../../widgets/search_field.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class ExploreHousingScreen extends StatefulWidget {
  const ExploreHousingScreen({super.key});

  @override
  State<ExploreHousingScreen> createState() => _ExploreHousingScreenState();
}

class _ExploreHousingScreenState extends State<ExploreHousingScreen> {
  final searchController = TextEditingController();
  late Set<ReportReason> selectedReasons = {};
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedPrice;
  String? selectedLocation;
  String? selectedFurnishingStatus;
  List<dynamic> allListingsHousings = [...allListingsHousingsGV];
  List allListingHousingsWithSubCategory = [];

  String allListingHousingsErrMsg = '';
  // final List<String> categories = [...housingListingCategoriesNamesGV];
  dynamic selectedPriceRange;
  List subCategories = [];
  final List<String> locations = [
    'Multan',
    'Lahore',
    'Karachi',
  ];

  final List<String> furnished = [
    'Yes',
    'No',
  ];

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  getAllHousings() async {
    Response response = await sendGetRequest('get_all_listings_housings');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    allListingsHousingsGV = [];
    if (status == 'success') {
      allListingsHousingsGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          allListingsHousings = allListingsHousingsGV;
          for (var house in allListingsHousings) {
            if (house['listings_sub_categories'] != null) {
              allListingHousingsWithSubCategory.add(house);
            }
          }
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (allListingsHousings.isEmpty) {
            allListingHousingsErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('allListingsHousings: $allListingsHousings');
  }

  searchHousingsByName(String value) {
    print(value);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        print(value);
        List<dynamic> filteredItems = [];

        for (var house in allListingsHousingsGV) {
          String houseName = house['name'];
          houseName = houseName.toLowerCase();
          if (houseName.contains(value.toLowerCase())) {
            filteredItems.add(house);
          }
        }
        if (mounted) {
          setState(() {
            allListingsHousings = filteredItems;
            if (allListingsHousings.isEmpty) {
              allListingHousingsErrMsg = 'No listing found.';
            } else {
              allListingHousingsErrMsg = '';
            }
          });
        }
      },
    );
  }

  filterHousings() {
    dynamic houseCategoryName;
    dynamic houseLocation;
    dynamic houseFurnishedStatus;
    double housePrice;
    allListingsHousings = allListingsHousingsGV;
    List<dynamic> filteredHousings = [];
    print('selectedPriceRange: $selectedPriceRange');
    print('selectedCategory: $selectedCategory');
    print('selectedLocation: $selectedLocation');
    print('selectedFurnishedStatus: $selectedFurnishingStatus');
    for (var house in allListingsHousings) {
      houseCategoryName = house['listings_categories']['name'];
      housePrice = double.parse(house['price']);
      houseLocation = house['location'];
      houseFurnishedStatus = house['furnished'];
      if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedPriceRange != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to'])) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedLocation != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null && selectedLocation != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedLocation != null && selectedFurnishingStatus != null) {
        if (houseLocation.contains(selectedLocation) &&
            houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null) {
        if (houseCategoryName.contains(selectedCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null) {
        if (housePrice >= selectedPriceRange['range_from'] &&
            housePrice <= selectedPriceRange['range_to']) {
          filteredHousings.add(house);
        }
      } else if (selectedLocation != null) {
        if (houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedFurnishingStatus != null) {
        if (houseFurnishedStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else {}
    }

    setState(() {
      allListingsHousings = filteredHousings;
      if (allListingsHousings.isEmpty) {
        allListingHousingsErrMsg = 'No listing found.';
      } else {
        allListingHousingsErrMsg = '';
      }
    });
  }

  filterHousingsHavingSubCategory() {
    dynamic houseCategoryName;
    dynamic houseLocation;
    dynamic houseFurnishingStatus;
    double housePrice;
    dynamic houseSubCategory;

    List<dynamic> filteredHousings = [];
    print('selectedPriceRange: $selectedPriceRange');
    print('selectedCategory: $selectedCategory');
    print('selectedLocation: $selectedLocation');
    print('selectedFurnishingStatus: $selectedFurnishingStatus');
    print('selectedSubCategory: $selectedSubCategory');
    for (var house in allListingHousingsWithSubCategory) {
      houseCategoryName = house['listings_categories']['name'];
      housePrice = double.parse(house['price']);
      houseLocation = house['location'];
      houseSubCategory = house['listings_sub_categories']['name'];
      houseFurnishingStatus = house['furnished'];
      if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null &&
          selectedSubCategory != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseSubCategory.contains(selectedSubCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedLocation != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseLocation.contains(selectedLocation) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedLocation != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedSubCategory != null &&
          selectedPriceRange != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseSubCategory.contains(selectedSubCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedSubCategory != null &&
          selectedLocation != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedLocation != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedSubCategory != null &&
          selectedLocation != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedLocation != null &&
          selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseLocation.contains(selectedLocation) &&
            houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedLocation != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedSubCategory != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseSubCategory.contains(selectedSubCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedPriceRange != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to'])) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedLocation != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null && selectedFurnishingStatus != null) {
        if (houseCategoryName.contains(selectedCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedSubCategory != null && selectedPriceRange != null) {
        if (houseSubCategory.contains(selectedSubCategory) &&
            (housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to'])) {
          filteredHousings.add(house);
        }
      } else if (selectedSubCategory != null && selectedLocation != null) {
        if (houseSubCategory.contains(selectedSubCategory) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedSubCategory != null &&
          selectedFurnishingStatus != null) {
        if (houseSubCategory.contains(selectedSubCategory) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null && selectedLocation != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null &&
          selectedFurnishingStatus != null) {
        if ((housePrice >= selectedPriceRange['range_from'] &&
                housePrice <= selectedPriceRange['range_to']) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedLocation != null && selectedFurnishingStatus != null) {
        if (houseLocation.contains(selectedLocation) &&
            houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else if (selectedCategory != null) {
        if (houseCategoryName.contains(selectedCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedSubCategory != null) {
        if (houseSubCategory.contains(selectedSubCategory)) {
          filteredHousings.add(house);
        }
      } else if (selectedLocation != null) {
        if (houseLocation.contains(selectedLocation)) {
          filteredHousings.add(house);
        }
      } else if (selectedPriceRange != null) {
        if (housePrice >= selectedPriceRange['range_from'] &&
            housePrice <= selectedPriceRange['range_to']) {
          filteredHousings.add(house);
        }
      } else if (selectedFurnishingStatus != null) {
        if (houseFurnishingStatus.contains(selectedFurnishingStatus)) {
          filteredHousings.add(house);
        }
      } else {}
    }

    setState(() {
      allListingsHousings = filteredHousings;
      if (allListingsHousings.isEmpty) {
        allListingHousingsErrMsg = 'No listing found.';
      } else {
        allListingHousingsErrMsg = '';
      }
    });
  }

  getHousingsPriceRanges() async {
    Response response = await sendPostRequest(
        action: 'listings_types_prices_ranges',
        data: {'listings_types_id': '3'});
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    housingsPriceRangesGV = decodedResponse['data'];
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
    selectedFurnishingStatus = null;
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

  init() {
    getAllHousings();
    getHousingsPriceRanges();
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
                      allListingsHousings = allListingsHousingsGV;
                    });
                    searchHousingsByName(value.trim());
                  },
                  searchController: searchController)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: housingsPriceRangesGV.isNotEmpty
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
                            filterHousings();
                          },
                          dropdownMenuEntries: housingListingCategoriesGV
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
                                      print(selectedSubCategory);
                                      print(value);
                                      filterHousingsHavingSubCategory();
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
                            if (selectedSubCategory != null) {
                              filterHousingsHavingSubCategory();
                            } else {
                              filterHousings();
                            }
                          },
                          dropdownMenuEntries: housingsPriceRangesGV
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
                            if (selectedSubCategory != null) {
                              filterHousingsHavingSubCategory();
                            } else {
                              filterHousings();
                            }
                          },
                          dropdownMenuEntries: locations
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList(),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        RoundedSmallDropdownMenu(
                          // trailingIconName: 'blue_address_icon',
                          width: 170,
                          leadingIconName: selectedFurnishingStatus != null
                              ? 'cat-selected'
                              : 'cat-unselected',
                          hintText: 'Furnished',
                          onSelected: (value) {
                            setState(() {
                              selectedFurnishingStatus = value;
                            });
                            if (selectedSubCategory != null) {
                              filterHousingsHavingSubCategory();
                            } else {
                              filterHousings();
                            }
                          },
                          dropdownMenuEntries: furnished
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
              'All Housings',
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
              child: allListingsHousings.isNotEmpty
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
                        mainAxisExtent: 206,
                      ),
                      itemCount: allListingsHousings.length,
                      itemBuilder: (context, index) {
                        return FeaturedHousingWidget(
                          furnishedStatus:
                              allListingsHousings[index]['furnished'] == 'Yes'
                                  ? 'Furnished'
                                  : 'Not Furnished',
                          image: imgBaseUrl +
                              allListingsHousings[index]['listings_images'][0]
                                  ['image'],
                          housingCategory: allListingsHousings[index]
                              ['listings_categories']['name'],
                          housingName: allListingsHousings[index]['name'],
                          housingLocation: allListingsHousings[index]
                              ['location'],
                          housingPrice: allListingsHousings[index]['price'],
                          area: allListingsHousings[index]['area'],
                          bedrooms: allListingsHousings[index]['bedroom'],
                          bathrooms: allListingsHousings[index]['bathroom'],
                          onImageTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HousingDetailsPage(
                                houseData: allListingsHousings[index],
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
                  : allListingsHousings.isEmpty &&
                          allListingHousingsErrMsg.isEmpty
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: GridView.builder(
                            padding: const EdgeInsets.only(bottom: 33, left: 2),
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
                          child: Text(allListingHousingsErrMsg),
                        ),
            ),
          )
        ],
      ),
    );
  }
}
