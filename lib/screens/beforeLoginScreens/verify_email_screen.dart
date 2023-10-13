import 'package:flutter/material.dart';
import 'package:sellpad/utils/Buttons.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/widgets/navigate_back_icon.dart';

import 'complete_profile_screen.dart';

class VerifyEmail extends StatefulWidget {
  static const String id = 'verify_email_screen';
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
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
                    '“ username@gmail.com”',
                    style: kColoredTextStyle,
                  ),
                  Text(
                    'Enter code below to verify.',
                    style: kTextFieldHintStyle,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpInputField(
                        padding: const EdgeInsets.only(right: 14.0, left: 14.0),
                        onChanged: (value) {
                          // if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          // }
                        },
                      ),
                      OtpInputField(
                        padding: const EdgeInsets.only(right: 14.0),
                        onChanged: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      OtpInputField(
                        padding: const EdgeInsets.only(right: 14.0),
                        onChanged: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      OtpInputField(
                        padding: const EdgeInsets.only(right: 14.0),
                        onChanged: (value) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
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
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CompleteProfileScreen.id);
                },
                child: Text(
                  'Skip for now',
                  style: kColoredBodyTextStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
              ),
              primaryButton(
                context,
                'Continue',
                () => Navigator.pushNamed(context, CompleteProfileScreen.id),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpInputField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final void Function(String)? onChanged;
  OtpInputField({required this.padding, this.onChanged});

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
