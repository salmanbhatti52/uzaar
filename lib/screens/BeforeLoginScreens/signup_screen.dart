import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:Uzaar/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:Uzaar/widgets/text_form_field_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Uzaar/widgets/text.dart';
import 'package:http/http.dart';

import '../../services/restService.dart';
import '../../widgets/suffix_svg_icon.dart';
import 'login_screen.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  BoxDecoration? firstNameFieldBoxDecoration;
  BoxDecoration? lastNameFieldBoxDecoration;
  BoxDecoration? emailFieldBoxDecoration;
  BoxDecoration? passwordFieldBoxDecoration;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences preferences;
  bool isHidden = true;
  bool setLoader = false;
  String setButtonStatus = 'Signup';
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
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
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
                        'Signup',
                        style: kAppBarTitleStyle,
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
                      TextFormFieldWidget(
                        focusedBorder: kRoundedActiveBorderStyle,
                        validator: (value) {
                          return null;
                        },
                        controller: firstNameController,
                        textInputType: TextInputType.name,
                        prefixIcon:
                            SvgIcon(imageName: 'assets/person-icon.svg'),
                        hintText: 'First Name',
                        obscureText: null,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Last Name')),
                      SizedBox(
                        height: 7.h,
                      ),
                      TextFormFieldWidget(
                        focusedBorder: kRoundedActiveBorderStyle,
                        validator: (value) {
                          return null;
                        },
                        controller: lastNameController,
                        textInputType: TextInputType.name,
                        prefixIcon:
                            SvgIcon(imageName: 'assets/person-icon.svg'),
                        hintText: 'Last Name',
                        obscureText: null,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Email')),
                      SizedBox(
                        height: 7.h,
                      ),
                      TextFormFieldWidget(
                        focusedBorder: kRoundedActiveBorderStyle,
                        validator: (value) {
                          return null;
                        },
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: SvgIcon(imageName: 'assets/email-icon.svg'),
                        hintText: 'username@gmail.com',
                        obscureText: null,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Password')),
                      SizedBox(
                        height: 7.h,
                      ),
                      TextFormFieldWidget(
                        focusedBorder: kRoundedActiveBorderStyle,
                        validator: (value) {
                          return null;
                        },
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
                      SizedBox(
                        height: 70.h,
                      ),
                      primaryButton(
                          context: context,
                          buttonText: setButtonStatus,
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) {
                          //       return VerifyEmail(
                          //           userEmail: emailController.text.toString());
                          //     },
                          //   ));
                          // },
                          onTap: () async {
                            String emailRegex =
                                r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
                            RegExp regex = RegExp(emailRegex);
                            if (firstNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter first name',
                                        style: kToastTextStyle,
                                      )));
                            } else if (lastNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter last name',
                                        style: kToastTextStyle,
                                      )));
                            } else if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter an email',
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
                                        'Please enter a password',
                                        style: kToastTextStyle,
                                      )));
                            } else {
                              setState(() {
                                setLoader = true;
                                setButtonStatus = 'Please wait..';
                              });
                              Response response = await sendPostRequest(
                                  action: 'signup_with_app',
                                  data: {
                                    'one_signal_id': '12345',
                                    'first_name':
                                        firstNameController.text.toString(),
                                    'last_name':
                                        lastNameController.text.toString(),
                                    'email': emailController.text.toString(),
                                    'password':
                                        passwordController.text.toString()
                                  });

                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Signup';
                              });
                              print(response.statusCode);
                              print(response.body);
                              var decodedResponse = jsonDecode(response.body);
                              String status = decodedResponse['status'];
                              String message = decodedResponse['message'];

                              if (status == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: primaryBlue,
                                        content: Text(
                                          'Success',
                                          style: kToastTextStyle,
                                        )));
                                // preferences.setString('firstName',
                                //     firstNameController.text.toString());
                                // preferences.setString('lastName',
                                //     lastNameController.text.toString());
                                // preferences.setString(
                                //     'email', emailController.text.toString());

                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyEmail(
                                        userEmail:
                                            emailController.text.toString()),
                                  ),
                                );
                              }
                              if (status == 'error') {
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
                      Container(
                        margin: EdgeInsets.only(bottom: 22),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
                            style: kBodyTextStyle,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    // Navigator.pushNamed(
                                    //     context, LogInScreen.id);
                                    // sendPostRequest()
                                    // sendPostRequest('signup_with_app', data);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LogInScreen()));
                                  },
                                text: 'Login',
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
