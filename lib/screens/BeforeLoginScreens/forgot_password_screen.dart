import 'dart:convert';

import 'package:Uzaar/screens/BeforeLoginScreens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../utils/Colors.dart';
import '../../widgets/navigate_back_icon.dart';
import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool setLoader = false;
  String setButtonStatus = 'Next';
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
            'Forgot Password?',
            style: kAppBarTitleStyle,
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Enter the Email address associated with your account. You will receive a confirmation code',
                style: kSimpleTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
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
                  prefixIcon: SvgIcon(imageName: 'assets/email-icon.svg'),
                  hintText: 'username@gmail.com',
                  obscureText: null,
                ),
              ),
              Spacer(),
              primaryButton(
                  context: context,
                  buttonText: setButtonStatus,
                  onTap: () async {
                    String emailRegex =
                        r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
                    RegExp regex = RegExp(emailRegex);
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Please enter your email',
                            style: kToastTextStyle,
                          )));
                    } else if (!regex.hasMatch(emailController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Enter a valid email',
                            style: kToastTextStyle,
                          )));
                    } else {
                      setState(() {
                        setLoader = true;
                        setButtonStatus = 'Please wait..';
                      });
                      Response response = await sendPostRequest(
                          action: 'forgot_password',
                          data: {
                            'email': emailController.text.toString(),
                          });
                      setState(() {
                        setLoader = false;
                        setButtonStatus = 'Next';
                      });
                      print(response.statusCode);
                      print(response.body);
                      var decodedResponse = jsonDecode(response.body);
                      String status = decodedResponse['status'];
                      String message = decodedResponse?['message'];
                      if (status == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: primaryBlue,
                            content: Text(
                              message,
                              style: kToastTextStyle,
                            )));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpScreen(
                              userEmail: emailController.text.toString()),
                        ));
                        // ignore: use_build_context_synchronously
                      }
                      if (status == 'error') {
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
    );
  }
}
