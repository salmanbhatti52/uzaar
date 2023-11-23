import 'package:Uzaar/screens/EditListingScreens/edit_listing_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/reusable_data.dart';
import '../../widgets/product_list_tile.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen(
      {super.key,
      required this.selectedCategory,
      required this.boostingPackages,
      required this.listedProducts});
  final int selectedCategory;
  final dynamic boostingPackages;
  final dynamic listedProducts;

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late int _selectedPackage;
  dynamic selectedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPackage = widget.boostingPackages?['data'][0]['packages_id'];
  }

  updateSelectedPackage(value) {
    _selectedPackage = value;
    print(_selectedPackage);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.listedProducts != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ProductListTile(
                  productImage: imgBaseUrl +
                      widget.listedProducts[index]['listings_images'][0]
                          ['image'],
                  productName: widget.listedProducts[index]['name'],
                  productLocation: 'California',
                  productPrice: '\$${widget.listedProducts[index]['price']}',
                  onSelected: (selectedValue) {
                    setState(() {
                      selectedOption = selectedValue;
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
                                    widget.boostingPackages?['data'].length,
                                    (index) => SizedBox(
                                      height: 35,
                                      child: ListTile(
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        horizontalTitleGap: 5,
                                        title: Text(
                                          '\$${widget.boostingPackages?['data'][index]['price']} ${widget.boostingPackages?['data'][index]['name']}',
                                          style: kTextFieldInputStyle,
                                        ),
                                        leading: Radio(
                                          activeColor: primaryBlue,
                                          fillColor: MaterialStatePropertyAll(
                                              primaryBlue),
                                          value:
                                              widget.boostingPackages?['data']
                                                  [index]['packages_id'],
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
                            listingData: widget.listedProducts[index],
                          ),
                        ));
                      } else if (selectedOption == 'delete') {
                      } else {}
                    });
                  },
                  itemBuilder: (context) {
                    return popupMenuOptions;
                  },
                  initialValue: selectedOption,
                );
              },
              itemCount: widget.listedProducts.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
            )
          : Shimmer.fromColors(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    margin:
                        EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
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
              ),
              baseColor: Colors.grey[500]!,
              highlightColor: Colors.grey[100]!),
    );
  }
}
