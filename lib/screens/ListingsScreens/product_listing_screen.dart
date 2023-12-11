import 'dart:convert';

import 'package:Uzaar/screens/EditListingScreens/edit_listing_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/reusable_data.dart';
import '../../widgets/product_list_tile.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({
    super.key,
    required this.selectedCategory,
    required this.boostingPackages,
  });
  final int selectedCategory;
  final List<dynamic> boostingPackages;

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late int _selectedPackage;
  dynamic selectedOption;
  List<dynamic> listedProducts = [...listedProductsGV];
  String listedProductsErrMsg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPackage = widget.boostingPackages[0]['packages_id'];
    init();
  }

  init() {
    getSellerProductsListing();
  }

  updateSelectedPackage(value) {
    _selectedPackage = value;
    print(_selectedPackage);
  }

  getSellerProductsListing() async {
    Response response =
        await sendPostRequest(action: 'get_listings_products', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    listedProductsGV = [];
    if (status == 'success') {
      listedProductsGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          listedProducts = listedProductsGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (listedProducts.isEmpty) {
            listedProductsErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('listedProducts: $listedProducts');
  }

  Future<String> deleteSelectedProduct({required int productListingId}) async {
    Response response =
        await sendPostRequest(action: 'delete_listings_products', data: {
      'listings_products_id': productListingId,
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if (status == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SuccessSnackBar(message: null));
      return 'success';
    }
    if (status == 'error') {
      String message = decodedResponse?['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: message));
      return 'error';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: listedProducts.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ProductListTile(
                  productImage: imgBaseUrl +
                      listedProducts[index]['listings_images'][0]['image'],
                  productName: listedProducts[index]['name'],
                  productLocation: 'California',
                  productPrice: '\$${listedProducts[index]['price']}',
                  onSelected: (selectedValue) async {
                    setState(() {
                      selectedOption = selectedValue;
                    });
                    print(selectedOption);
                    if (selectedOption == 'boost') {
                      showDialog(
                        context: context,
                        builder: (
                          context,
                        ) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter stateSetterObject) {
                              return AlertDialogReusable(
                                description:
                                    'Boost your listings to get more orders',
                                title: 'Boost Listings',
                                itemsList: List.generate(
                                  widget.boostingPackages.length,
                                  (index) => SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      horizontalTitleGap: 5,
                                      title: Text(
                                        '\$${widget.boostingPackages[index]['price']} ${widget.boostingPackages[index]['name']}',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: Radio(
                                        activeColor: primaryBlue,
                                        fillColor: MaterialStatePropertyAll(
                                            primaryBlue),
                                        value: widget.boostingPackages[index]
                                            ['packages_id'],
                                        groupValue: _selectedPackage,
                                        onChanged: (value) {
                                          stateSetterObject(() {
                                            updateSelectedPackage(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                button: primaryButton(
                                    context: context,
                                    buttonText: 'Boost Now',
                                    onTap: () => Navigator.of(context).pop(),
                                    showLoader: false),
                              );
                            },
                          );
                        },
                      );
                    } else if (selectedOption == 'edit') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditListingScreen(
                          selectedCategory: widget.selectedCategory,
                          listingData: listedProducts[index],
                        ),
                      ));
                    } else if (selectedOption == 'delete') {
                      String result = await deleteSelectedProduct(
                          productListingId: listedProducts[index]
                              ['listings_products_id']);
                      if (result == 'success') {
                        listedProducts.removeAt(index);
                        setState(() {});
                      }
                    } else {}
                  },
                  itemBuilder: (context) {
                    return popupMenuOptions;
                  },
                  initialValue: selectedOption,
                );
              },
              itemCount: listedProducts.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
            )
          : listedProducts.isEmpty && listedProductsErrMsg.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        margin: EdgeInsets.only(
                            top: 2, left: 5, right: 5, bottom: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      );
                    },
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                  ))
              : Center(
                  child: Text(listedProductsErrMsg),
                ),
    );
  }
}
