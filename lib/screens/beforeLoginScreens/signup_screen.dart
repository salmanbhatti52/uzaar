import 'package:flutter/gestures.dart';
import 'package:sellpad/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:sellpad/widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellpad/widgets/text.dart';

import '../../widgets/suffix_svg_icon.dart';
import 'LogInScreen.dart';
import 'package:sellpad/utils/Buttons.dart';
import 'package:sellpad/utils/Colors.dart';

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
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
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
                      SizedBox(
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
                          child: TextFormFieldWidget(
                            controller: firstNameController,
                            textInputType: TextInputType.name,
                            prefixIcon:
                                SvgIcon(imageName: 'assets/person-icon.svg'),
                            hintText: 'First Name',
                            obscureText: null,
                          ),
                        ),
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
                      SizedBox(
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
                          child: TextFormFieldWidget(
                            controller: lastNameController,
                            textInputType: TextInputType.name,
                            prefixIcon:
                                SvgIcon(imageName: 'assets/person-icon.svg'),
                            hintText: 'Last Name',
                            obscureText: null,
                          ),
                        ),
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
                      SizedBox(
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
                          child: TextFormFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            prefixIcon:
                                SvgIcon(imageName: 'assets/email-icon.svg'),
                            hintText: 'username@gmail.com',
                            obscureText: null,
                          ),
                        ),
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
                      SizedBox(
                        height: 50.h,
                        child: Container(
                          decoration: kTextFieldBoxDecoration,
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
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VerifyEmail(),
                          ),
                        ),
                        child: primaryButton(context, 'Signup'),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 22.0.h),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
                            style: kBodyTextStyle,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, LogInScreen.id);
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
