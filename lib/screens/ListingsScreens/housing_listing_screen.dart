import 'package:Uzaar/widgets/housing_list_tile.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../EditListingScreens/edit_listing_screen.dart';

enum BoostingPackages { pkg1, pkg2, pkg3, pkg4 }

class HousingListingScreen extends StatefulWidget {
  HousingListingScreen({super.key, required this.selectedCategory});
  int selectedCategory;

  @override
  State<HousingListingScreen> createState() => _HousingListingScreenState();
}

class _HousingListingScreenState extends State<HousingListingScreen> {
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
          return HousingListTile(
            houseImage: 'assets/listed_house_img.png',
            houseName: '2 bedroom house',
            houseLocation: 'Los Angeles',
            housePrice: '\$1200',
            houseArea: '4500',
            houseType: 'Rental',
            noOfBaths: '2',
            noOfBeds: '2',
            onSelected: (selectedValue) {
              setState(() {
                selectedOption = selectedValue;
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
