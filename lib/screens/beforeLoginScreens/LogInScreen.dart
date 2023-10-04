import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellpad/screens/beforeLoginScreens/ResetPasswordScreen.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';
import 'package:sellpad/widgets/text.dart';

import 'SignUpScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
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
                      SvgPicture.asset('assets/app-logo.svg'),
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
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
                          child: TextFormFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            enterTextStyle: kTextFieldInputStyle,
                            cursorColor: primaryBlue,
                            prefixIcon:
                                SvgIcon(imageName: 'assets/email-icon.svg'),
                            hintText: 'username@gmail.com',
                            border: kRoundedWhiteBorderStyle,
                            hintStyle: kTextFieldHintStyle,
                            focusedBorder: kRoundedActiveBorderStyle,
                            obscureText: null,
                            enableBorder: kRoundedWhiteBorderStyle,
                          ),
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
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
                          child: TextFormFieldWidget(
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            enterTextStyle: kTextFieldInputStyle,
                            cursorColor: primaryBlue,
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
                            border: kRoundedWhiteBorderStyle,
                            hintStyle: kTextFieldHintStyle,
                            focusedBorder: kRoundedActiveBorderStyle,
                            obscureText: isHidden,
                            enableBorder: kRoundedWhiteBorderStyle,
                          ),
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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPasswordScreen(),
                                      ),
                                    );
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
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BottomNavBar(),
                          ),
                        ),
                        child: primaryButton(context, 'Login'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      googleButton(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      facebookButton(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      outlinedButton(context),
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?  ',
                            style: kBodyTextStyle,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
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
