import 'package:Uzaar/utils/reusable_data.dart';
import 'package:Uzaar/widgets/service_list_tile.dart';
import 'package:flutter/material.dart';

import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../EditListingScreens/edit_listing_screen.dart';

class ServiceListingScreen extends StatefulWidget {
  const ServiceListingScreen(
      {super.key,
      required this.selectedCategory,
      required this.boostingPackages});
  final int selectedCategory;
  final dynamic boostingPackages;
  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
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
          return ServiceListTile(
            serviceImage: 'assets/listed_service_img.png',
            serviceName: 'Graphic Design',
            serviceLocation: 'Los Angeles',
            servicePrice: '\$12',
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
