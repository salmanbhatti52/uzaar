import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellpad/screens/HomeScreen.dart';
import 'package:sellpad/screens/beforeLoginScreens/reset_password_screen.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';
import 'package:sellpad/widgets/text.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 50.h,
                      child: TextFormFieldWidget(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: SvgIcon(imageName: 'assets/email-icon.svg'),
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
                      height: 50.h,
                      child: TextFormFieldWidget(
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
                                  Navigator.pushNamed(
                                      context, ResetPasswordScreen.id);
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
                      context,
                      'Login',
                      () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const BottomNavBar()),
                            (Route<dynamic> route) => false);
                      },
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
                                  Navigator.pushNamed(context, SignUpScreen.id);
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
    );
  }
}
