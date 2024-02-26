import 'dart:convert';

import 'package:uzaar/screens/ProfileScreens/PersonalProfileScreens/profile_reviews_screen.dart';
import 'package:uzaar/screens/ProfileScreens/edit_profile_screen.dart';
import 'package:uzaar/screens/ProfileScreens/apply_for_verification_screen.dart';

import 'package:uzaar/widgets/get_stars_tile.dart';
import 'package:uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/getImage.dart';
import '../../../services/restService.dart';
import '../../../widgets/DrawerWidget.dart';
import '../../../widgets/business_type_button.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/text.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../BeforeLoginScreens/add_image_screen.dart';
import '../../chat_list_screen.dart';
import '../../notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String userProfile = '';
  int selectedCategory = 1;
  late SharedPreferences preferences;
  String selectedImageInBase64 = '';
  late Map<String, dynamic> images;
  int _tapCount = 0;
  Future<Map<String, dynamic>> updateProfile() async {
    Response response =
        await sendPostRequest(action: 'update_profile_image', data: {
      'users_customers_id': userDataGV['userId'].toString(),
      'profile_pic': selectedImageInBase64
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    dynamic data = decodedResponse['data'];

    if (status == 'success') {
      // update for Global Var
      userDataGV['profilePic'] = imgBaseUrl + data['profile_pic'];
      setState(() {
        userProfile = userDataGV['profilePic'];
      });
      // update for shared  preferences
      await preferences.setString('profile_pic', userDataGV['profilePic']);

      return {'status': status};
    }
    setState(() {
      userProfile = userDataGV['profilePic'];
    });
    String message = decodedResponse['message'];
    return {'status': status, 'message': message};
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController.text = userDataGV['firstName'];
    lastNameController.text = userDataGV['lastName'];
    emailController.text = userDataGV['email'];
    phoneNumberController.text = userDataGV['phoneNumber'] ?? '';
    addressController.text = userDataGV['address'] ?? '';
    userProfile = userDataGV['profilePic'];
    initPrefs();
  }

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    isProfileVerified();
  }

  isProfileVerified() async {
    Response response = await sendPostRequest(
        action: 'is_verification_applied',
        data: {"users_customers_id": userDataGV['userId']});
    print('isProfileVerified: ${response.body}');
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];

    if (status == 'success') {
      Map data = decodedResponse['data'];
      setState(() {
        profileVerificationStatusGV = data['verification_applied'];
      });
    } else if (status == 'error') {
      setState(() {
        profileVerificationStatusGV = '';
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _tapCount++;
        print(_tapCount);
        if (_tapCount == 1) {
        } else if (_tapCount >= 2) {
          // Pop the navigator after the second tap
          SystemNavigator.pop();
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: black),
            elevation: 0.0,
            backgroundColor: Colors.white,
            leadingWidth: 70,
            leading: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: SvgPicture.asset(
                    'assets/drawer-button.svg',
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MessagesScreen(),
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
                          builder: (context) => const NotificationScreen(),
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
              'Profile',
              style: kAppBarTitleStyle,
            ),
          ),
          drawer: DrawerWidget(
            buildContext: context,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: primaryBlue,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: GestureDetector(
                          onTap: () async {
                            var data = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ));
                            print('Data Recieved: $data');

                            firstNameController.text = userDataGV['firstName'];
                            lastNameController.text = userDataGV['lastName'];
                            emailController.text = userDataGV['email'];
                            phoneNumberController.text =
                                userDataGV['phoneNumber'] ?? '';
                            addressController.text =
                                userDataGV['address'] ?? '';
                          },
                          child: SvgPicture.asset(
                            'assets/edit_profile.svg',
                          ),
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        // alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: userProfile != ''
                                  ? Image.network(
                                      userProfile,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          profileVerificationStatusGV == 'Approved'
                              ? Positioned(
                                  left: -10,
                                  top: -7,
                                  child: GestureDetector(
                                    onTap: null,
                                    child: SvgPicture.asset(
                                      'assets/verified_icon.svg',
                                    ),
                                  ),
                                )
                              : const Positioned(child: SizedBox()),
                          Positioned(
                            right: -7,
                            bottom: -1,
                            child: GestureDetector(
                              onTap: () async {
                                var result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: const AddImageScreen()),
                                  ),
                                );
                                print(result);
                                if (result == 'camera') {
                                  images = await getImage(from: 'camera');

                                  selectedImageInBase64 =
                                      images['image']['imageInBase64'];
                                  if (selectedImageInBase64 != '') {
                                    setState(() {
                                      userProfile = '';
                                    });
                                    Map<String, dynamic> result =
                                        await updateProfile();
                                    if (result['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SuccessSnackBar(message: null));
                                    }
                                    if (result['status'] == 'error') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(ErrorSnackBar(
                                              message: result['message']));
                                    }
                                  }
                                }
                                if (result == 'gallery') {
                                  images = await getImage(from: 'gallery');

                                  selectedImageInBase64 =
                                      images['image']['imageInBase64'];
                                  if (selectedImageInBase64 != '') {
                                    setState(() {
                                      userProfile = '';
                                    });
                                    Map<String, dynamic> result =
                                        await updateProfile();
                                    if (result['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SuccessSnackBar(message: null));
                                    }
                                    if (result['status'] == 'error') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(ErrorSnackBar(
                                              message: result['message']));
                                    }
                                  }
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/add-pic-button.svg',
                                // fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      profileVerificationStatusGV != 'Approved'
                          ? GestureDetector(
                              onTap: () async {
                                if (profileVerificationStatusGV.isEmpty ||
                                    profileVerificationStatusGV == 'Declined') {
                                  String result = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ApplyForVerificationScreen(),
                                  ));
                                  if (result != '') {
                                    setState(() {
                                      profileVerificationStatusGV = result;
                                    });
                                  }
                                }
                              },
                              child: Text(
                                profileVerificationStatusGV.isEmpty ||
                                        profileVerificationStatusGV ==
                                            'Declined'
                                    ? 'Apply for Verification'
                                    : profileVerificationStatusGV == 'Pending'
                                        ? 'Applied for Verification'
                                        : '',
                                textAlign: TextAlign.center,
                                style: kFontSixteenSixHPB,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 7,
                      ),
                      const StarsTile(
                        noOfStars: 5,
                        alignment: MainAxisAlignment.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '(14)',
                        style: kFontSixteenSixHB,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = 1;
                              });
                            },
                            child: BusinessTypeButton(
                              width: 100,
                              businessName: 'Personal Info',
                              gradient: selectedCategory == 1 ? gradient : null,
                              buttonBackground: selectedCategory != 1
                                  ? grey.withOpacity(0.3)
                                  : null,
                              textColor: selectedCategory == 1 ? white : grey,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = 2;
                              });
                            },
                            child: BusinessTypeButton(
                              width: 100,
                              businessName: 'Reviews',
                              gradient: selectedCategory == 2 ? gradient : null,
                              buttonBackground: selectedCategory != 2
                                  ? grey.withOpacity(0.3)
                                  : null,
                              textColor: selectedCategory == 2 ? white : grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      selectedCategory == 1
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 22),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReusableText(text: 'First Name'),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextFormFieldWidget(
                                      focusedBorder: kRoundedWhiteBorderStyle,
                                      readOnly: true,
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
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: ReusableText(text: 'Last Name')),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextFormFieldWidget(
                                      focusedBorder: kRoundedWhiteBorderStyle,
                                      readOnly: true,
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
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: ReusableText(text: 'Email')),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextFormFieldWidget(
                                      focusedBorder: kRoundedWhiteBorderStyle,
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
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          ReusableText(text: 'Phone Number')),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextFormFieldWidget(
                                      focusedBorder: kRoundedWhiteBorderStyle,
                                      readOnly: true,
                                      controller: phoneNumberController,
                                      textInputType: TextInputType.phone,
                                      prefixIcon: const SvgIcon(
                                          imageName: 'assets/phone-fill.svg'),
                                      hintText: '+4156565662',
                                      obscureText: null,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: ReusableText(text: 'Address')),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextFormFieldWidget(
                                      focusedBorder: kRoundedWhiteBorderStyle,
                                      readOnly: true,
                                      controller: addressController,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      prefixIcon: SvgPicture.asset(
                                        'assets/address-icon.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
                                      suffixIcon: SvgPicture.asset(
                                        'assets/address-icon.svg',
                                        fit: BoxFit.scaleDown,
                                        colorFilter: const ColorFilter.mode(
                                            primaryBlue, BlendMode.srcIn),
                                      ),
                                      hintText: 'Address',
                                      obscureText: null,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const ProfileReviewsScreen()
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
