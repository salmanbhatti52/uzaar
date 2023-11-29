import 'dart:convert';

import 'package:Uzaar/utils/reusable_data.dart';
import 'package:Uzaar/widgets/service_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/snackbars.dart';
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
  dynamic listedServices;
  updateSelectedPackage(value) {
    _selectedPackage = value;
    print(_selectedPackage);
  }

  init() {
    getSellerServicesListing();
  }

  getSellerServicesListing() async {
    Response response =
        await sendPostRequest(action: 'get_listings_services', data: {
      'users_customers_id': userDataGV['userId'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    listedServices = decodedResponse['data'];
    print('listedServices: $listedServices');
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> deleteSelectedService({required int serviceListingId}) async {
    Response response =
        await sendPostRequest(action: 'delete_listings_services', data: {
      'listings_services_id': serviceListingId,
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
    _selectedPackage = widget.boostingPackages?['data'][0]['packages_id'];
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: listedServices != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ServiceListTile(
                  serviceImage: imgBaseUrl +
                      listedServices[index]['listings_images'][0]['image'],
                  serviceName: listedServices[index]['name'],
                  serviceLocation: listedServices[index]['location'],
                  servicePrice: '\$${listedServices[index]['price']}',
                  onSelected: (selectedValue) async {
                    setState(() {
                      selectedOption = selectedValue;
                    });
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
                          listingData: listedServices[index],
                          selectedCategory: widget.selectedCategory,
                        ),
                      ));
                    } else if (selectedOption == 'delete') {
                      String result = await deleteSelectedService(
                          serviceListingId: listedServices[index]
                              ['listings_services_id']);
                      if (result == 'success') {
                        listedServices.removeAt(index);
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
              itemCount: listedServices.length,
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
