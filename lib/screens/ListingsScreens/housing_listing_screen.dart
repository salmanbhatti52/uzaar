import 'dart:convert';

import 'package:uzaar/models/app_data.dart';
import 'package:uzaar/widgets/housing_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../utils/reusable_data.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/snackbars.dart';
import '../BusinessDetailPages/payment_screen.dart';
import '../EditListingScreens/edit_listing_screen.dart';

class HousingListingScreen extends StatefulWidget {
  const HousingListingScreen(
      {super.key,
      required this.selectedListingType,
      required this.boostingPackages});
  final int selectedListingType;
  final List<dynamic> boostingPackages;

  @override
  State<HousingListingScreen> createState() => _HousingListingScreenState();
}

class _HousingListingScreenState extends State<HousingListingScreen> {
  late int _selectedPackageId;
  late Map selectedPackage;
  dynamic selectedOption;
  late AppData appData;
  List<dynamic> listedHousings = [];
  String listedHousingsErrMsg = '';

  updateSelectedPackage(selectedPackageId) {
    for (Map package in widget.boostingPackages) {
      if (package['packages_id'] == selectedPackageId) {
        selectedPackage = package;
        break;
      }
    }
    _selectedPackageId = selectedPackageId;
    print(_selectedPackageId);
  }

  getSellerHousingListing() async {
    Response response =
        await sendPostRequest(action: 'get_listings_housings', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    appData.listedHousingsGV = [];
    if (status == 'success') {
      appData.listedHousingsGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          listedHousings = appData.listedHousingsGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (listedHousings.isEmpty) {
            listedHousingsErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('listedHousings: $listedHousings');
  }

  Future<String> deleteSelectedHouse({required int houseListingId}) async {
    Response response =
        await sendPostRequest(action: 'delete_listings_housings', data: {
      'listings_housings_id': houseListingId,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPackageId = widget.boostingPackages[0]['packages_id'];
    selectedPackage = widget.boostingPackages[0];
    init();
  }

  init() {
    getSellerHousingListing();
  }

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context);
    listedHousings = [...appData.listedHousingsGV];
    return Expanded(
      child: listedHousings.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return HousingListTile(
                  houseImage: imgBaseUrl +
                      listedHousings[index]['listings_images'][0]['image'],
                  houseName: listedHousings[index]['name'],
                  houseLocation: listedHousings[index]['location'],
                  housePrice: '\$${listedHousings[index]['price']}',
                  houseArea: listedHousings[index]['area'],
                  furnishedStatus: listedHousings[index]['furnished'] == 'Yes'
                      ? 'Furnished'
                      : 'Not Furnished',
                  noOfBaths: listedHousings[index]['bathroom'],
                  noOfBeds: listedHousings[index]['bathroom'],
                  onSelected: (selectedValue) async {
                    setState(() {});
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
                                  widget.boostingPackages.length,
                                  (index) => SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      horizontalTitleGap: 5,
                                      title: Text(
                                        '\$${widget.boostingPackages[index]['price']} ${widget.boostingPackages[index]['name']}',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: Radio(
                                        activeColor: primaryBlue,
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                primaryBlue),
                                        value: widget.boostingPackages[index]
                                            ['packages_id'],
                                        groupValue: _selectedPackageId,
                                        onChanged: (selectedPackageId) {
                                          stateSetterObject(() {
                                            updateSelectedPackage(
                                                selectedPackageId);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                button: primaryButton(
                                    context: context,
                                    buttonText: 'Boost Now',
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
                                            listingHousingId:
                                                listedHousings[index]
                                                    ['listings_housings_id'],
                                            selectedPackage: selectedPackage,
                                            userCustomerPackagesId: listedHousings[
                                                        index]?[
                                                    'users_customers_packages']
                                                ?[
                                                'users_customers_packages_id']),
                                      ));
                                    },
                                    showLoader: false),
                              );
                            },
                          );
                        },
                      );
                    } else if (selectedOption == 'edit') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditListingScreen(
                          listingData: listedHousings[index],
                          selectedListingType: widget.selectedListingType,
                        ),
                      ));
                    } else if (selectedOption == 'delete') {
                      String result = await deleteSelectedHouse(
                          houseListingId: listedHousings[index]
                              ['listings_housings_id']);
                      if (result == 'success') {
                        setState(() {
                          listedHousings.removeAt(index);
                          appData.listedHousingsGV = listedHousings;
                          if (listedHousings.isEmpty) {
                            listedHousingsErrMsg = 'No listing found.';
                          }
                        });
                      }
                    } else {}
                  },
                  itemBuilder: (context) {
                    return popupMenuOptions;
                  },
                  initialValue: selectedOption,
                );
              },
              itemCount: listedHousings.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            )
          : listedHousings.isEmpty && listedHousingsErrMsg.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.only(
                            top: 2, left: 5, right: 5, bottom: 14),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      );
                    },
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                  ))
              : Center(
                  child: Text(listedHousingsErrMsg),
                ),
    );
  }
}
