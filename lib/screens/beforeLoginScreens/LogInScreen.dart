import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'package:sellpad/widgets/text.dart';

import 'SignUpScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    passwordController = TextEditingController();
    emailController = TextEditingController();
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
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
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
                          enterTextStyle: kTextFieldInputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/email-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'username@gmail.com',
                          border: kBorderStyle,
                          hintStyle: kTextFieldInputStyle,
                          focusedBorder: kBorderStyle,
                          obscureText: null,
                          enableBorder: kBorderStyle,
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
                          enterTextStyle: kTextFieldInputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/password-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: isHidden
                                ? SvgPicture.asset(
                                    'assets/hide-pass-icon.svg',
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                    fit: BoxFit.scaleDown,
                                  )
                                : SvgPicture.asset(
                                    'assets/show-pass.svg',
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                  ),
                          ),
                          hintText: '***************',
                          border: kBorderStyle,
                          hintStyle: kTextFieldHintStyle,
                          focusedBorder: kBorderStyle,
                          obscureText: isHidden,
                          enableBorder: kBorderStyle,
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
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const VerifyEmail(),
                                      ),
                                    );
                                  },
                                text: 'Reset',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryBlue,
                                ).copyWith(
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
                        height: 30.h,
                      ),
                      googleButton(context),
                      SizedBox(
                        height: 30.h,
                      ),
                      facebookButton(context),
                      SizedBox(
                        height: 30.h,
                      ),
                      outlinedButton(context),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'nt have an account?  ',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
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
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryBlue,
                                ).copyWith(
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
