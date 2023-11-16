import 'dart:convert';
import 'dart:io';

import 'package:Uzaar/screens/BeforeLoginScreens/add_image_screen.dart';
import 'package:Uzaar/services/location.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/services/xFiletoBase64.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:Uzaar/widgets/text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/text_form_field_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';

import '../../utils/Buttons.dart';
import '../../widgets/read_only_container.dart';
import '../BusinessDetailPages/BottomSheetForSendOffer.dart';
import 'package:Uzaar/services/getImage.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const String id = 'complete_profile_screen';
  dynamic userData;
  CompleteProfileScreen({super.key, required this.userData});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  XFile? _selectedImage;
  late SharedPreferences preferences;
  String firstName = '';
  String lastName = '';
  String email = '';
  late double latitude;
  late double longitude;
  late Position position;
  String selectedImageInBase64 = '';
  bool setLoader = false;
  String setButtonStatus = 'Continue';
  late int userId;
  late Map<String, dynamic> images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPreferences();
    if (widget.userData != null) {
      userId = widget.userData['users_customers_id'];
      firstName = widget.userData['first_name'];
      lastName = widget.userData['last_name'];
      email = widget.userData['email'];
    }
  }

  setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Future _selectImageFromGallery() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnedImage == null) {
  //     return;
  //   }
  //
  //   setState(() {
  //     _selectedImage = returnedImage;
  //   });
  //   selectedImageInBase64 = await convertXFileToBase64(_selectedImage!);
  //   print(selectedImageInBase64);
  // }
  //
  // Future _takeImageFromCamera() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnedImage == null) {
  //     return;
  //   }
  //   setState(() {
  //     _selectedImage = returnedImage;
  //   });
  //   selectedImageInBase64 = await convertXFileToBase64(_selectedImage!);
  //   print(selectedImageInBase64);
  // }

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
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Complete Profile',
            style: kAppBarTitleStyle,
          ),
        ),
        backgroundColor: white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _selectedImage != null
                                  ? Image.file(
                                      File(_selectedImage!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          Positioned(
                            right: -10,
                            child: GestureDetector(
                              onTap: () => showModalBottomSheet(
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.vertical(
                                //       top: Radius.circular(20)),
                                // ),
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: AddImageScreen(
                                        fromCamera: () async {
                                          Navigator.pop(context);
                                          images =
                                              await getImage(from: 'camera');
                                          setState(() {
                                            _selectedImage =
                                                images['selectedImage'];
                                          });
                                          selectedImageInBase64 =
                                              images['selectedImageInBase64'];
                                        },
                                        fromGallery: () async {
                                          Navigator.pop(context);
                                          images =
                                              await getImage(from: 'gallery');
                                          setState(() {
                                            _selectedImage =
                                                images['selectedImage'];
                                          });
                                          selectedImageInBase64 =
                                              images['selectedImageInBase64'];
                                        },
                                      )),
                                ),
                              ),
                              child: SvgIcon(
                                  imageName: 'assets/add-pic-button.svg'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'First Name'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/person-icon.svg', firstName),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Last Name')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/person-icon.svg', lastName),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Email')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/email-icon.svg', email),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Phone Number')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          controller: phoneNumberController,
                          textInputType: TextInputType.phone,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/phone-fill.svg'),
                          hintText: '+4156565662',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Address')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          // onSubmitted: (value) {
                          //   print('address: $value');
                          // },
                          controller: addressController,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/address-icon.svg'),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              position = await getLocationCoordinates();
                              print(position);
                              List<Placemark> placemarks =
                                  await getLocationFromCoordinates(
                                      position.latitude, position.longitude);
                              print(
                                  '${placemarks[0].thoroughfare!}, ${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}');
                              setState(() {
                                addressController.text =
                                    '${placemarks[0].thoroughfare!}, ${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}';
                              });
                            },
                            child: SvgIcon(
                              imageName: 'assets/address-icon.svg',
                              colorFilter: ColorFilter.mode(
                                  primaryBlue, BlendMode.srcIn),
                            ),
                          ),
                          hintText: 'Your Address Here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await preferences.setBool('loginAsGuest', false);
                          await preferences.setInt(
                              'user_id', widget.userData['users_customers_id']);
                          await preferences.setString(
                              'first_name', widget.userData['first_name']);
                          await preferences.setString(
                              'last_name', widget.userData['last_name']);
                          await preferences.setString(
                              'email', widget.userData['email']);
                          await preferences.setString('profile_pic', '');
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                            builder: (context) {
                              return BottomNavBar(
                                loginAsGuest: false,
                              );
                            },
                          ), (route) => false);
                        },
                        child: Text(
                          'Skip for now',
                          style: kColoredBodyTextStyle.copyWith(
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      primaryButton(
                          context: context,
                          buttonText: setButtonStatus,
                          onTap: () async {
                            if (selectedImageInBase64.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please add your profile pic',
                                        style: kToastTextStyle,
                                      )));
                            } else if (phoneNumberController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter your phone number',
                                        style: kToastTextStyle,
                                      )));
                            } else if (addressController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please add your address',
                                        style: kToastTextStyle,
                                      )));
                            } else {
                              // i get latitude and longitude here because user can type address we need latitude and longitude accordingly,
                              // if i set it onChange then as user types as functionality called i think it is not very good way,

                              print(
                                  'address: ${addressController.text.toString()}');
                              setState(() {
                                setLoader = true;
                                setButtonStatus = 'Please wait..';
                              });
                              try {
                                List<Location> locations =
                                    await locationFromAddress(
                                        addressController.text.toString());
                                print(locations);
                                print(locations[0].longitude);
                                print(locations[0].latitude);
                                latitude = locations[0].latitude;
                                longitude = locations[0].longitude;

                                Response response = await sendPostRequest(
                                    action: 'complete_profile',
                                    data: {
                                      'users_customers_id': userId.toString(),
                                      'phone':
                                          phoneNumberController.text.toString(),
                                      'address':
                                          addressController.text.toString(),
                                      'latitude': latitude.toString(),
                                      'longitude': longitude.toString(),
                                      'profile_pic': selectedImageInBase64,
                                    });
                                setState(() {
                                  setLoader = false;
                                  setButtonStatus = 'Continue';
                                });
                                print(response.statusCode);
                                print(response.body);
                                var decodedResponse = jsonDecode(response.body);
                                String status = decodedResponse['status'];

                                if (status == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: primaryBlue,
                                          content: Text(
                                            'Success',
                                            style: kToastTextStyle,
                                          )));
                                  dynamic data = decodedResponse['data'];
                                  await preferences.setBool(
                                      'loginAsGuest', false);
                                  await preferences.setInt(
                                      'user_id', data['users_customers_id']);
                                  await preferences.setString(
                                      'first_name', data['first_name']);
                                  await preferences.setString(
                                      'last_name', data['last_name']);
                                  await preferences.setString(
                                      'email', data['email']);
                                  await preferences.setString('profile_pic',
                                      imgBaseUrl + data['profile_pic']);
                                  await preferences.setString(
                                      'phone_number', data['phone']);
                                  await preferences.setString(
                                      'address', data['address']);
                                  await preferences.setString(
                                      'latitude', data['latitude']);
                                  await preferences.setString(
                                      'longitude', data['longitude']);

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return BottomNavBar(
                                        loginAsGuest: false,
                                      );
                                    },
                                  ), (route) => false);

                                  // ignore: use_build_context_synchronously
                                }
                                if (status == 'error') {
                                  String message = decodedResponse?['message'];
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            message,
                                            style: kToastTextStyle,
                                          )));
                                }
                              } catch (e) {
                                print(e);
                                setState(() {
                                  setLoader = false;
                                  setButtonStatus = 'Continue';
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Plz enter a valid address',
                                          style: kToastTextStyle,
                                        )));
                              }
                            }
                          },
                          showLoader: setLoader),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
