import 'dart:convert';

import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/location.dart';
import '../../utils/Colors.dart';
import '../../widgets/BottomNaviBar.dart';
import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  late String latitude;
  late String longitude;
  late Position position;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController.text = userDataGV['firstName'];
    lastNameController.text = userDataGV['lastName'];
    emailController.text = userDataGV['email'];
    addressController.text = userDataGV['address'] ?? '';
    phoneNumberController.text = userDataGV['phoneNumber'] ?? '';
    latitude = userDataGV['latitude'] ?? '';
    longitude = userDataGV['longitude'] ?? '';
    initPrefs();
  }

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'assets/back-arrow-button.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessagesScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/msg-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/notification-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          title: Text(
            'Edit Profile',
            style: kAppBarTitleStyle,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(text: 'First Name'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 46,
                      child: TextFormFieldWidget(
                        controller: firstNameController,
                        textInputType: TextInputType.name,
                        prefixIcon: SvgPicture.asset(
                          'assets/person-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: 'First Name',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Last Name')),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 46,
                      child: TextFormFieldWidget(
                        controller: lastNameController,
                        textInputType: TextInputType.name,
                        prefixIcon: SvgPicture.asset(
                          'assets/person-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: 'Last Name',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Email')),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 46,
                      child: TextFormFieldWidget(
                        readOnly: true,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(
                          'assets/email-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: 'username@gmail.com',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Phone Number')),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 46,
                      child: TextFormFieldWidget(
                        controller: phoneNumberController,
                        textInputType: TextInputType.phone,
                        prefixIcon: SvgIcon(imageName: 'assets/phone-fill.svg'),
                        hintText: '+4156565662',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Address')),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 46,
                      child: TextFormFieldWidget(
                        // onSubmitted: (value) {
                        //   print('address: $value');
                        // },
                        controller: addressController,
                        textInputType: TextInputType.streetAddress,
                        prefixIcon: SvgPicture.asset(
                          'assets/address-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            try {
                              position = await getLocationCoordinates();
                              print(position);

                              List<Placemark> placemarks =
                                  await getLocationFromCoordinates(
                                      position.latitude, position.longitude);
                              print(placemarks);
                              print(
                                  '${placemarks[0].thoroughfare!}, ${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}');
                              setState(() {
                                addressController.text =
                                    '${placemarks[0].thoroughfare!}, ${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}';
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ErrorSnackBar(message: e.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ErrorSnackBar(
                                      message:
                                          'Plz check your device location is on'));
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     AlertSnackBar(
                              //         message:
                              //             'we need permission to access your location'));
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/address-icon.svg',
                            fit: BoxFit.scaleDown,
                            colorFilter:
                                ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                          ),
                        ),
                        hintText: 'Address',
                        obscureText: null,
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.17,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      onTap: () async {
                        if (phoneNumberController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Please enter your phone number',
                                style: kToastTextStyle,
                              )));
                        } else if (addressController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Please add your address',
                                style: kToastTextStyle,
                              )));
                        } else {
                          // i get latitude and longitude here because user can type address we need latitude and longitude accordingly,
                          // if i set it onChange then as user types as functionality called i think it is not very good way,
                          setState(() {
                            setLoader = true;
                            setButtonStatus = 'Please wait..';
                          });
                          print(
                              'address: ${addressController.text.toString()}');
                          try {
                            List<Location> locations =
                                await locationFromAddress(
                                    addressController.text.toString());
                            print(locations);
                            print(locations[0].longitude);
                            print(locations[0].latitude);
                            latitude = locations[0].latitude.toString();
                            longitude = locations[0].longitude.toString();

                            Response response = await sendPostRequest(
                                action: 'edit_profile',
                                data: {
                                  'users_customers_id':
                                      userDataGV['userId'].toString(),
                                  'first_name':
                                      firstNameController.text.toString(),
                                  'last_name':
                                      lastNameController.text.toString(),
                                  'phone':
                                      phoneNumberController.text.toString(),
                                  'address': addressController.text.toString(),
                                  'latitude': latitude,
                                  'longitude': longitude
                                });
                            setState(() {
                              setLoader = false;
                              setButtonStatus = 'Save Changes';
                            });
                            print(response.statusCode);
                            print(response.body);
                            var decodedResponse = jsonDecode(response.body);
                            String status = decodedResponse['status'];

                            if (status == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SuccessSnackBar(message: null));
//update for preferences when app restarts
                              await preferences.setString('first_name',
                                  firstNameController.text.toString());
                              await preferences.setString('last_name',
                                  lastNameController.text.toString());
                              await preferences.setString('phone_number',
                                  phoneNumberController.text.toString());
                              await preferences.setString(
                                  'address', addressController.text.toString());
                              await preferences.setString('latitude', latitude);
                              await preferences.setString(
                                  'longitude', longitude);
//update for global variable
                              userDataGV['firstName'] =
                                  firstNameController.text.toString();
                              userDataGV['lastName'] =
                                  lastNameController.text.toString();
                              userDataGV['phoneNumber'] =
                                  phoneNumberController.text.toString();
                              userDataGV['address'] =
                                  addressController.text.toString();
                              userDataGV['latitude'] = latitude.toString();
                              userDataGV['longitude'] = longitude.toString();

                              print(userDataGV);
                              Navigator.pop(context, userDataGV);
                              // dynamic data = decodedResponse['data'];
                              // ignore: use_build_context_synchronously
                            }
                            if (status == 'error') {
                              String message = decodedResponse?['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(message: message),
                              );
                            }
                          } catch (e) {
                            print('exception: $e');
                            setState(() {
                              setLoader = false;
                              setButtonStatus = 'Save Changes';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Plz enter a valid address',
                                  style: kToastTextStyle,
                                )));
                          }
                        }
                      },
                      showLoader: setLoader),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
