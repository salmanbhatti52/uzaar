import 'dart:convert';

import 'package:uzaar/screens/BusinessDetailPages/product_details_page.dart';
import 'package:uzaar/widgets/rounded_small_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/featured_products_widget.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/search_field.dart';
import '../../widgets/snackbars.dart';


class ExploreProductsScreen extends StatefulWidget {
  const ExploreProductsScreen({super.key});

  @override
  State<ExploreProductsScreen> createState() => _ExploreProductsScreenState();
}

class _ExploreProductsScreenState extends State<ExploreProductsScreen> {
  final searchController = TextEditingController();
  late String selectedReason = '';
  late int selectedReasonId;
  String setSendReportButtonStatus = 'Send';
  bool setSendReportButtonLoader = false;
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedCondition;
  String? selectedPrice;
  List<dynamic> allListingsProducts = [...allListingsProductsGV];
  List allListingProductsWithSubCategory = [];
  String allListingProductsErrMsg = '';
  // List<String> categories = [...productListingCategoriesNamesGV];
  dynamic selectedPriceRange;
  List subCategories = [];

  final List<String> productConditions = [
    'New',
    'Used',
  ];

  getAllProducts() async {
    Response response = await sendGetRequest('get_all_listings_products');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);

    String status = decodedResponse['status'];
    allListingsProductsGV = [];
    if (status == 'success') {
      allListingsProductsGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          allListingsProducts = allListingsProductsGV;
          for (var product in allListingsProducts) {
            if (product['listings_sub_categories'] != null) {
              allListingProductsWithSubCategory.add(product);
            }
          }
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (allListingsProducts.isEmpty) {
            allListingProductsErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('allListingsProducts: $allListingsProducts');
  }

  searchProductsByName(String value) {
    print(value);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        print(value);
        List<dynamic> filteredItems = [];

        for (var product in allListingsProductsGV) {
          String productName = product['name'];
          productName = productName.toLowerCase();
          if (productName.contains(value.toLowerCase())) {
            filteredItems.add(product);
          }
        }
        if (mounted) {
          setState(() {
            allListingsProducts = filteredItems;
            if (allListingsProducts.isEmpty) {
              allListingProductsErrMsg = 'No listing found.';
            } else {
              allListingProductsErrMsg = '';
            }
          });
        }
      },
    );
  }

  filterProducts() {
    dynamic productCategoryName;
    dynamic productCondition;
    double productPrice;
    allListingsProducts = allListingsProductsGV;
    List<dynamic> filteredProducts = [];
    print('selectedPriceRange: $selectedPriceRange');
    print('selectedCategory: $selectedCategory');
    print('productCondition: $selectedCondition');
    for (var product in allListingsProducts) {
      productCategoryName = product['listings_categories']['name'];
      productPrice = double.parse(product['price']);
      productCondition = product['condition'];
      if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedCondition != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null && selectedPriceRange != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to'])) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null && selectedCondition != null) {
        if (productCategoryName.contains(selectedCategory) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedPriceRange != null && selectedCondition != null) {
        if ((productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null) {
        if (productCategoryName.contains(selectedCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedCondition != null) {
        if (productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedPriceRange != null) {
        if (productPrice >= selectedPriceRange['range_from'] &&
            productPrice <= selectedPriceRange['range_to']) {
          filteredProducts.add(product);
        }
      } else {}
    }

    setState(() {
      allListingsProducts = filteredProducts;
      if (allListingsProducts.isEmpty) {
        allListingProductsErrMsg = 'No listing found.';
      } else {
        allListingProductsErrMsg = '';
      }
    });
  }

  filterProductsHavingSubCategory() {
    dynamic productCategoryName;
    dynamic productCondition;
    double productPrice;
    dynamic productSubCategory;

    List<dynamic> filteredProducts = [];
    print('selectedPriceRange: $selectedPriceRange');
    print('selectedCategory: $selectedCategory');
    print('productCondition: $selectedCondition');
    print('selectedSubCategory: $selectedSubCategory');
    for (var product in allListingProductsWithSubCategory) {
      productCategoryName = product['listings_categories']['name'];
      productPrice = double.parse(product['price']);
      productCondition = product['condition'];
      productSubCategory = product['listings_sub_categories']['name'];
      if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedCondition != null &&
          selectedSubCategory != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productCondition.contains(selectedCondition) &&
            productSubCategory.contains(selectedSubCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null &&
          selectedSubCategory != null &&
          selectedPriceRange != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productSubCategory.contains(selectedSubCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null &&
          selectedSubCategory != null &&
          selectedCondition != null) {
        if (productCategoryName.contains(selectedCategory) &&
            productSubCategory.contains(selectedSubCategory) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null &&
          selectedPriceRange != null &&
          selectedCondition != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedPriceRange != null &&
          selectedSubCategory != null &&
          selectedCondition != null) {
        if ((productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productSubCategory.contains(selectedSubCategory) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null && selectedSubCategory != null) {
        if (productCategoryName.contains(selectedCategory) &&
            productSubCategory.contains(selectedSubCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null && selectedPriceRange != null) {
        if (productCategoryName.contains(selectedCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to'])) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null && selectedCondition != null) {
        if (productCategoryName.contains(selectedCategory) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedSubCategory != null && selectedPriceRange != null) {
        if (productSubCategory.contains(selectedSubCategory) &&
            (productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to'])) {
          filteredProducts.add(product);
        }
      } else if (selectedSubCategory != null && selectedCondition != null) {
        if (productSubCategory.contains(selectedSubCategory) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedPriceRange != null && selectedCondition != null) {
        if ((productPrice >= selectedPriceRange['range_from'] &&
                productPrice <= selectedPriceRange['range_to']) &&
            productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedCategory != null) {
        if (productCategoryName.contains(selectedCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedSubCategory != null) {
        if (productSubCategory.contains(selectedSubCategory)) {
          filteredProducts.add(product);
        }
      } else if (selectedCondition != null) {
        if (productCondition.contains(selectedCondition)) {
          filteredProducts.add(product);
        }
      } else if (selectedPriceRange != null) {
        if (productPrice >= selectedPriceRange['range_from'] &&
            productPrice <= selectedPriceRange['range_to']) {
          filteredProducts.add(product);
        }
      } else {}
    }

    setState(() {
      allListingsProducts = filteredProducts;
      if (allListingsProducts.isEmpty) {
        allListingProductsErrMsg = 'No listing found.';
      } else {
        allListingProductsErrMsg = '';
      }
    });
  }

  getProductsPriceRanges() async {
    Response response = await sendPostRequest(
        action: 'listings_types_prices_ranges',
        data: {'listings_types_id': '1'});
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    productsPriceRangesGV = decodedResponse['data'];
    if (mounted) {
      setState(() {});
    }
  }

  getCategorySubCategories({required int categoryId}) async {
    subCategories = [];
    selectedSubCategory = null;
    selectedCondition = null;
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

  Future<String> reportListing({required int listingId, required int listingTypeId, required int listingCategoriesId, required int listingReportReasonId,}) async{
    Response response = await sendPostRequest(action: 'add_listings_reports', data: {
      "listings_id": listingId,
      "listings_types_id": listingTypeId,
      "listings_categories_id": listingCategoriesId,
      "users_customers_id": userDataGV['userId'],
      "listings_reports_reasons_id": listingReportReasonId
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if(status == 'success'){
      return status;
    }else if(status == 'error'){
      return decodedResponse['message'];
    }else{
      return '';
    }
  }


  init() {
    getAllProducts();
    getProductsPriceRanges();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                      allListingsProducts = allListingsProductsGV;
                    });
                    searchProductsByName(value.trim());
                  },
                  searchController: searchController)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
              child: productsPriceRangesGV.isNotEmpty
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
                            filterProducts();
                          },
                          dropdownMenuEntries: productListingCategoriesGV
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
                                      filterProductsHavingSubCategory();
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
                          width: 165,
                          leadingIconName: selectedCondition != null
                              ? 'cat-selected'
                              : 'cat-unselected',
                          hintText: 'Condition',
                          onSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                            if (selectedSubCategory != null) {
                              filterProductsHavingSubCategory();
                            } else {
                              filterProducts();
                            }
                          },
                          dropdownMenuEntries: productConditions
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
                            // findMatchedPriceItems(value);
                            selectedPriceRange = value;
                            if (selectedSubCategory != null) {
                              filterProductsHavingSubCategory();
                            } else {
                              filterProducts();
                            }
                          },
                          dropdownMenuEntries: productsPriceRangesGV
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
              'All Products',
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
              child: allListingsProducts.isNotEmpty
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
                        mainAxisExtent: 180,
                      ),
                      itemCount: allListingsProducts.length,
                      itemBuilder: (context, index) {
                        return FeaturedProductsWidget(
                          sellerProfileVerified: allListingsProducts[index]
                              ['users_customers']['badge_verified'],
                          productCondition: allListingsProducts[index]
                              ['condition'],
                          image: imgBaseUrl +
                              allListingsProducts[index]['listings_images'][0]
                                  ['image'],
                          productCategory: allListingsProducts[index]
                              ['listings_categories']['name'],
                          productName: allListingsProducts[index]['name'],
                          // productLocation: 'California',
                          productPrice: allListingsProducts[index]['price'],
                          onImageTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  productData: allListingsProducts[index],
                                ),
                              ),
                            );
                          },
                          onOptionTap: () {
                            if(userDataGV['userId'] == allListingsProducts[index]['users_customers_id']){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ErrorSnackBar(
                                      message: 'You can only see your listings'));
                            }else{
                              showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter stateSetterObject) {
                                    return AlertDialogReusable(
                                      description:
                                      'Select any reason to report. We will show you less listings like this next time.',
                                      title: 'Report Listing',
                                      itemsList:List.generate(
                                        listingsReportReasonsGV
                                            .length,
                                            (index) =>
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  listingsReportReasonsGV[
                                                  index]
                                                  ['reason'],
                                                  style:
                                                  kTextFieldInputStyle,
                                                ),
                                                leading:
                                                GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(
                                                            () {
                                                          selectedReason =
                                                          listingsReportReasonsGV[index]
                                                          [
                                                          'reason'];
                                                          selectedReasonId = listingsReportReasonsGV[index]['listings_reports_reasons_id'];
                                                        });
                                                  },
                                                  child: SvgPicture.asset(selectedReason ==
                                                      listingsReportReasonsGV[index]
                                                      [
                                                      'reason']
                                                      ? 'assets/selected_check.svg'
                                                      : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                      ),
                                      button: primaryButton(
                                          context: context,
                                          buttonText: setSendReportButtonStatus,
                                          onTap: () async {
                                            stateSetterObject((){
                                              setSendReportButtonStatus = 'Please wait..';
                                              setSendReportButtonLoader = true;
                                            });
                                            String apiResponse = await reportListing(
                                                listingId: allListingsProducts[index]['listings_products_id'],
                                                listingTypeId: allListingsProducts[index]['listings_types_id'],
                                                listingCategoriesId: allListingsProducts[index]['listings_categories_id'],
                                                listingReportReasonId: selectedReasonId
                                            );

                                            stateSetterObject((){

                                              setSendReportButtonStatus = 'Send';
                                              setSendReportButtonLoader = false;
                                            });
                                            if(apiResponse == 'success'){

                                              ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Listing Reported'));

                                            }else if(apiResponse.isNotEmpty && apiResponse != 'success'){

                                              ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: apiResponse));

                                            }
                                            Navigator.of(
                                                context)
                                                .pop();
                                          },
                                          showLoader: setSendReportButtonLoader),);
                                  },
                                ),
                              );
                            }

                          },
                        );
                      },
                    )
                  : allListingsProducts.isEmpty &&
                          allListingProductsErrMsg.isEmpty
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
                          child: Text(allListingProductsErrMsg),
                        ),
            ),
          )
        ],
      ),
    );
  }
}
