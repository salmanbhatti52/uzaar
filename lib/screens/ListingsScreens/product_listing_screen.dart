import 'package:Uzaar/screens/EditListingScreens/edit_listing_screen.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';
import '../../widgets/product_list_tile.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen(
      {super.key,
      required this.selectedCategory,
      required this.boostingPackages});
  final int selectedCategory;
  final dynamic boostingPackages;

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
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ProductListTile(
            productImage: 'assets/listed_pro_img.png',
            productName: 'Iphone 14',
            productLocation: 'Los Angeles',
            productPrice: '\$12',
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
                                    fillColor:
                                        MaterialStatePropertyAll(primaryBlue),
                                    value: widget.boostingPackages?['data']
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
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
