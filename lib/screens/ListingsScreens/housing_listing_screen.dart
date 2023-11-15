import 'package:Uzaar/widgets/housing_list_tile.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../EditListingScreens/edit_listing_screen.dart';

class HousingListingScreen extends StatefulWidget {
  const HousingListingScreen(
      {super.key,
      required this.selectedCategory,
      required this.boostingPackages});
  final int selectedCategory;
  final dynamic boostingPackages;

  @override
  State<HousingListingScreen> createState() => _HousingListingScreenState();
}

class _HousingListingScreenState extends State<HousingListingScreen> {
  late int _selectedPackage;
  dynamic selectedOption;
  updateSelectedPackage(value) {
    _selectedPackage = value;
    print(_selectedPackage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPackage = widget.boostingPackages?['data'][0]['packages_id'];
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
