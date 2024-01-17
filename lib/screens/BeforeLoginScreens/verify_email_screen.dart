import 'dart:convert';

import 'package:uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:uzaar/utils/Buttons.dart';
import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/navigate_back_icon.dart';
import 'package:http/http.dart';
import '../../widgets/custom_otp_field.dart';
import 'complete_profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VerifyEmail extends StatefulWidget {
  static const String id = 'verify_email_screen';
  final String userEmail;

  const VerifyEmail({required this.userEmail, super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
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
            'Verify Email',
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
                        child: GestureDetector(
                          onTap: () async {
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
                          child: RichText(
                            text: TextSpan(
                              text: 'Didn’t Receive? ',
                              style: kBodyTextStyle,
                              children: [
                                TextSpan(
                                  // recognizer: TapGestureRecognizer()
                                  //   ..onTap = () {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (context) => const ResetPasswordScreen(),
                                  //       ),
                                  //     );
                                  //   },
                                  text: 'Resend',
                                  style: kColoredBodyTextStyle.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.pushNamed(context, CompleteProfileScreen.id);
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => CompleteProfileScreen(),
                  //         ));
                  //   },
                  //   child: Text(
                  //     'Skip for now',
                  //     style: kColoredBodyTextStyle.copyWith(
                  //         decoration: TextDecoration.underline),
                  //   ),
                  // ),
                  primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      // onTap: () {
                      //   dynamic userData;
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) {
                      //       return CompleteProfileScreen(
                      //         userData: userData,
                      //       );
                      //     },
                      //   ));
                      // },
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
                              action: 'verify_email_verification_otp',
                              data: {
                                'email': widget.userEmail,
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

                          if (status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: primaryBlue,
                                content: Text(
                                  'Email verified',
                                  style: kToastTextStyle,
                                )));
                            dynamic userData = decodedResponse['data'];
                            print('userData: $userData');
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CompleteProfileScreen(
                                  userData: userData,
                                );
                              },
                            ));
                            // ignore: use_build_context_synchronously
                          }
                          if (status == 'error') {
                            String message = decodedResponse['message'];
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      ),
    );
  }
}

class OtpInputField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  const OtpInputField(
      {super.key, required this.padding, this.onChanged, this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 60,
        width: 50,
        child: Container(
          decoration: kOtpBoxDecoration,
          child: TextFormField(
            // autofocus: fa,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: onChanged,
            onSaved: (pin1) {},
            onEditingComplete: onEditingComplete,
            cursorColor: primaryBlue,
            decoration: kOptInputDecoration,
            textAlign: TextAlign.center,
            style: kTextFieldInputStyle,
          ),
        ),
      ),
    );
  }
}
