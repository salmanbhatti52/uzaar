import 'dart:convert';

import 'package:Uzaar/screens/BeforeLoginScreens/forgot_password_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';

import 'package:Uzaar/widgets/text_form_field_reusable.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:Uzaar/widgets/text.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signup_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = true;
  bool setLoader = false;
  bool setGuestButtonLoader = false;
  String setButtonStatus = 'Login';
  String setGuestButtonStatus = 'Continue as Guest';
  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPreferences();
  }

  setPreferences() async {
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 57.h,
                      ),
                      SvgIcon(imageName: 'assets/app_logo.svg'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Login',
                        style: kAppBarTitleStyle,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Email'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/email-icon.svg'),
                          hintText: 'username@gmail.com',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Password'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/password-icon.svg'),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: isHidden
                                ? SvgIcon(
                                    imageName: 'assets/show-pass.svg',
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                  )
                                : SvgIcon(
                                    imageName: 'assets/hide-pass-icon.svg',
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                  ),
                          ),
                          hintText: '***************',
                          obscureText: isHidden,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'Forgot Password? ',
                            style: kBodyTextStyle,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(),
                                        ));
                                    // Navigator.pushNamed(
                                    //     context, ResetPasswordScreen.id);
                                  },
                                text: 'Reset',
                                style: kColoredBodyTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      primaryButton(
                          context: context,
                          buttonText: setButtonStatus,
                          onTap: () async {
                            String emailRegex =
                                r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
                            RegExp regex = RegExp(emailRegex);
                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter your email',
                                        style: kToastTextStyle,
                                      )));
                            } else if (!regex.hasMatch(emailController.text)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Enter a valid email',
                                        style: kToastTextStyle,
                                      )));
                            } else if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter your password',
                                        style: kToastTextStyle,
                                      )));
                            } else {
                              setState(() {
                                setLoader = true;
                                setButtonStatus = 'Please wait..';
                              });
                              Response response = await sendPostRequest(
                                  action: 'login_with_app',
                                  data: {
                                    'one_signal_id': '12345',
                                    'email': emailController.text.toString(),
                                    'password':
                                        passwordController.text.toString()
                                  });
                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Login';
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

                                await preferences.setString(
                                    'profile_pic',
                                    data['profile_pic'] != null
                                        ? imgBaseUrl + data['profile_pic']
                                        : '');
                                await preferences.setString('profile_path_url',
                                    data['profile_pic'] ?? '');

                                await preferences.setString(
                                    'phone_number', data['phone'] ?? '');
                                await preferences.setString(
                                    'address', data['address'] ?? '');
                                await preferences.setString(
                                    'latitude', data['latitude'] ?? '');
                                await preferences.setString(
                                    'longitude', data['longitude'] ?? '');
                                await preferences.setBool(
                                    'order_status',
                                    data['order_status'] == 'ON'
                                        ? true
                                        : false);
                                await preferences.setBool('reviews_status',
                                    data['reviews'] == 'ON' ? true : false);
                                await preferences.setBool('offers_status',
                                    data['offers'] == 'ON' ? true : false);

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar(
                                              requiredScreenIndex: 0,
                                              loginAsGuest: false,
                                            )),
                                    (Route<dynamic> route) => false);
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
                            }
                          },
                          showLoader: setLoader),
                      googleButton(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      facebookButton(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      outlinedButton(
                        buttonText: setGuestButtonStatus,
                        showLoader: setGuestButtonLoader,
                        context: context,
                        onTap: () async {
                          setState(() {
                            setGuestButtonLoader = true;
                            setGuestButtonStatus = 'Please wait..';
                          });
                          Response response = await sendPostRequest(
                              action: 'continue_as_guest', data: null);

                          setState(() {
                            setGuestButtonLoader = false;
                            setGuestButtonStatus = 'Continue as Guest';
                          });
                          print(response.statusCode);
                          print(response.body);
                          var decodedResponse = jsonDecode(response.body);
                          String status = decodedResponse['status'];
                          if (status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SuccessSnackBar(message: 'Success'));
                            var data = decodedResponse['data'];
                            await preferences.setInt(
                                'user_id', data['users_customers_id']);
                            await preferences.setString('guest_user_name',
                                '${data['first_name']} ${data['last_name']}');
                            await preferences.setString(
                                'guest_user_email', data['email']);

                            await preferences.setBool('loginAsGuest', true);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                          requiredScreenIndex: 0,
                                          loginAsGuest: true,
                                        )),
                                (Route<dynamic> route) => false);
                          }
                          if (status == 'error') {
                            String message = decodedResponse?['message'];
                            ScaffoldMessenger.of(context)
                                .showSnackBar(ErrorSnackBar(message: message));
                          }
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 22),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?  ',
                            style: kBodyTextStyle,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.pushNamed(context, SignUpScreen.id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ));
                                  },
                                text: 'Signup',
                                style: kColoredBodyTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
