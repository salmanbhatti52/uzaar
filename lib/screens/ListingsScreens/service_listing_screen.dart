import 'dart:convert';

import 'package:uzaar/models/app_data.dart';
import 'package:uzaar/utils/reusable_data.dart';
import 'package:uzaar/widgets/service_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
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
      required this.selectedListingType,
      required this.boostingPackages});
  final int selectedListingType;
  final List<dynamic> boostingPackages;
  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
  late int _selectedPackage;
  dynamic selectedOption;
  late AppData appData;
  List<dynamic> listedServices = [];
  String listedServicesErrMsg = '';
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
    String status = decodedResponse['status'];
    appData.listedServicesGV = [];
    if (status == 'success') {
      appData.listedServicesGV = decodedResponse['data'];
      if (mounted) {
        setState(() {
          listedServices = appData.listedServicesGV;
        });
      }
    }

    if (status == 'error') {
      if (mounted) {
        setState(() {
          if (listedServices.isEmpty) {
            listedServicesErrMsg = 'No listing found.';
          }
        });
      }
    }

    print('listedServices: $listedServices');
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
    _selectedPackage = widget.boostingPackages[0]['packages_id'];
    init();
  }

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context);
    listedServices = [...appData.listedServicesGV];
    return Expanded(
      child: listedServices.isNotEmpty
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
                          selectedListingType: widget.selectedListingType,
                        ),
                      ));
                    } else if (selectedOption == 'delete') {
                      String result = await deleteSelectedService(
                          serviceListingId: listedServices[index]
                              ['listings_services_id']);
                      if (result == 'success') {
                        listedServices.removeAt(index);
                        setState(() {
                          if (listedServices.isEmpty) {
                            listedServicesErrMsg = 'No listing found.';
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
              itemCount: listedServices.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            )
          : listedServices.isEmpty && listedServicesErrMsg.isEmpty
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
                  child: Text(listedServicesErrMsg),
                ),
    );
  }
}
