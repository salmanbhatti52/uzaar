import 'dart:convert';

import 'package:Uzaar/screens/BeforeLoginScreens/reset_password_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:http/http.dart';
import '../../widgets/custom_otp_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OtpScreen extends StatefulWidget {
  final String userEmail;

  const OtpScreen({required this.userEmail, super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool showSpinner = false;
  String otpValue = '';
  bool setLoader = false;
  String setButtonStatus = 'Continue';

  String onSubmitted(String value) {
    otpValue = '';
    print('old otp: $otpValue');
    print(value);
    otpValue = value;
    print('new otp: $otpValue');
    return value;
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: NavigateBack(
              buildContext: context,
            ),
            title: Text(
              'OTP',
              style: kAppBarTitleStyle,
            ),
            elevation: 0.0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: ModalProgressHUD(
              color: Colors.white,
              dismissible: true,
              // blur: 0.0,
              inAsyncCall: showSpinner,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        // SizedBox(
                        //   height: 40,
                        // ),
                        Text(
                          'We have send a verification code to your email',
                          style: kSimpleTextStyle,
                        ),
                        Text(
                          '“ ${widget.userEmail}”',
                          style: kColoredTextStyle,
                        ),
                        Text(
                          'Enter code below to verify.',
                          style: kTextFieldHintStyle,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomOTPField(
                          length: 4, // Adjust the length as needed
                          onSubmitted: onSubmitted,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: 'Didn’t Receive? ',
                              style: kBodyTextStyle,
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      Response response = await sendPostRequest(
                                          action: 'resend_otp',
                                          data: {'email': widget.userEmail});
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      print(response.statusCode);
                                      print(response.body);
                                      var decodedResponse =
                                          jsonDecode(response.body);
                                      String status = decodedResponse['status'];
                                      String message =
                                          decodedResponse['message'];
                                      if (status == 'success') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: primaryBlue,
                                                content: Text(
                                                  message,
                                                  style: kToastTextStyle,
                                                )));
                                        // ignore: use_build_context_synchronously
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
                                    },
                                  text: 'Resend',
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
                    primaryButton(
                        context: context,
                        buttonText: setButtonStatus,
                        // onTap: () {},
                        onTap: () async {
                          if (otpValue.characters.length < 4) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'OTP is incomplete',
                                  style: kToastTextStyle,
                                )));
                            print(otpValue);
                            print('Otp is incomplete');
                          } else {
                            print('success');
                            setState(() {
                              setLoader = true;
                              setButtonStatus = 'Please wait..';
                            });
                            Response response = await sendPostRequest(
                                action: 'verify_forgot_password_otp',
                                data: {
                                  'email': widget.userEmail,
                                  // 'email': 'testing123@gmail.com',
                                  'otp': otpValue
                                });
                            setState(() {
                              setLoader = false;
                              setButtonStatus = 'Continue';
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
                                        message,
                                        style: kToastTextStyle,
                                      )));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ResetPasswordScreen(
                                    otp: otpValue,
                                    email: widget.userEmail,
                                  );
                                },
                              ));
                              // ignore: use_build_context_synchronously
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
                        showLoader: setLoader)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
