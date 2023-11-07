import 'package:Uzaar/screens/EditListingScreens/edit_listing_screen.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';
import '../../widgets/product_list_tile.dart';

enum BoostingPackages { pkg1, pkg2, pkg3, pkg4 }

class ProductListingScreen extends StatefulWidget {
  ProductListingScreen({super.key, required this.selectedCategory});
  int selectedCategory;

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  BoostingPackages? _selectedPackage = BoostingPackages.pkg1;
  dynamic selectedOption;
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
                            itemsList: [
                              SizedBox(
                                height: 35,
                                child: ListTile(
                                  title: Text(
                                    '\$1 Per Day for 1 Item',
                                    style: kTextFieldInputStyle,
                                  ),
                                  leading: Radio(
                                    activeColor: primaryBlue,
                                    value: BoostingPackages.pkg1,
                                    groupValue: _selectedPackage,
                                    onChanged: (value) {
                                      stateSetterObject(() {
                                        updateSelectedPackage(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: ListTile(
                                  title: Text(
                                    '\$5 Per Week for 1 Item',
                                    style: kTextFieldInputStyle,
                                  ),
                                  leading: Radio(
                                    activeColor: primaryBlue,
                                    value: BoostingPackages.pkg2,
                                    groupValue: _selectedPackage,
                                    onChanged: (value) {
                                      stateSetterObject(() {
                                        updateSelectedPackage(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: ListTile(
                                  title: Text(
                                    '\$10 Per Month for 1 Item',
                                    style: kTextFieldInputStyle,
                                  ),
                                  leading: Radio(
                                    activeColor: primaryBlue,
                                    value: BoostingPackages.pkg3,
                                    groupValue: _selectedPackage,
                                    onChanged: (value) {
                                      stateSetterObject(() {
                                        updateSelectedPackage(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: ListTile(
                                  title: Text(
                                    '\$20 Per Month for Unlimited Items',
                                    style: kTextFieldInputStyle,
                                  ),
                                  leading: Radio(
                                    activeColor: primaryBlue,
                                    value: BoostingPackages.pkg4,
                                    groupValue: _selectedPackage,
                                    onChanged: (value) {
                                      stateSetterObject(() {
                                        updateSelectedPackage(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
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
