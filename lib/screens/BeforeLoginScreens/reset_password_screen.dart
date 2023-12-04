import 'dart:convert';

import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:Uzaar/widgets/text.dart';
import 'package:http/http.dart';

import '../../services/restService.dart';
import '../../widgets/text_form_field_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';
  final String otp;
  final String email;
  const ResetPasswordScreen(
      {super.key, required this.otp, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHiddenNew = true;
  bool isHiddenConfirm = true;
  bool setLoader = false;
  String setButtonStatus = 'Save';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: NavigateBack(
            buildContext: context,
          ),
          centerTitle: true,
          title: Text('Reset Password', style: kAppBarTitleStyle),
        ),
        backgroundColor: white,
        body: SafeArea(
          child: Form(
            key: _key,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  ReusableText(text: 'New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextFormFieldWidget(
                      focusedBorder: kRoundedActiveBorderStyle,
                      controller: newPassController,
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon:
                          SvgIcon(imageName: 'assets/password-icon.svg'),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isHiddenNew = !isHiddenNew;
                          });
                        },
                        child: isHiddenNew
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
                      obscureText: isHiddenNew,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableText(text: 'Confirm New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextFormFieldWidget(
                      focusedBorder: kRoundedActiveBorderStyle,
                      controller: confirmNewPassController,
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon:
                          SvgIcon(imageName: 'assets/password-icon.svg'),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isHiddenConfirm = !isHiddenConfirm;
                          });
                        },
                        child: isHiddenConfirm
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
                      obscureText: isHiddenConfirm,
                    ),
                  ),
                  Spacer(),
                  primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      // onTap: () {
                      //   // Navigator.push(
                      //   //     context,
                      //   //     MaterialPageRoute(
                      //   //       builder: (context) => LogInScreen(),
                      //   //     ));
                      //   // Navigator.pushNamed(context, LogInScreen.id);
                      // },
                      onTap: () async {
                        if (newPassController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Please enter new password',
                                style: kToastTextStyle,
                              )));
                        } else if (confirmNewPassController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Please re-enter new password',
                                style: kToastTextStyle,
                              )));
                        } else {
                          setState(() {
                            print('entered in setstate');
                            setLoader = true;
                            setButtonStatus = 'Please wait..';
                          });
                          print('entered in setstate');
                          Response response = await sendPostRequest(
                              action: 'reset_password',
                              data: {
                                'email': widget.email,
                                'otp': widget.otp,
                                'password': newPassController.text.toString(),
                                'confirm_password':
                                    confirmNewPassController.text.toString()
                              });
                          setState(() {
                            setLoader = false;
                            setButtonStatus = 'Save';
                          });
                          print(response.statusCode);
                          print(response.body);
                          var decodedResponse = jsonDecode(response.body);
                          String status = decodedResponse['status'];
                          if (status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: primaryBlue,
                                content: Text(
                                  'Success',
                                  style: kToastTextStyle,
                                )));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return LogInScreen();
                              },
                            ));
                            // ignore: use_build_context_synchronously
                          }
                          if (status == 'error') {
                            String message = decodedResponse?['message'];
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  message,
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
    );
  }
}
