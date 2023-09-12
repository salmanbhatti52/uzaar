import 'package:SellPad/widgets/TextfromFieldWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CompleteProfileScreen.dart';
import 'LogInScreen.dart';
import 'constants/Buttons.dart';
import 'constants/Colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  Widget text(String text) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    );
  }

  final TextStyle hintStyle = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: grey,
  );

  final TextStyle inputStyle = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: black,
  );

  final InputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: BorderSide(
      color: grey,
      width: 1,
    ),
  );

  final InputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: BorderSide(
      color: primaryBlue,
      width: 1,
    ),
  );

  final InputBorder enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: BorderSide(
      color: primaryBlue,
      width: 1,
    ),
  );

  final contentPadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 16);

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
                        child: text('First Name'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: firstNameController,
                          textInputType: TextInputType.name,
                          enterTextStyle: inputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/person-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'First Name',
                          border: outlineBorder,
                          hintStyle: hintStyle,
                          focusedBorder: focusBorder,
                          obscureText: null,
                          enableBorder: enableBorder,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Last Name')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: lastNameController,
                          textInputType: TextInputType.name,
                          enterTextStyle: inputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/person-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Last Name',
                          border: outlineBorder,
                          hintStyle: hintStyle,
                          focusedBorder: focusBorder,
                          obscureText: null,
                          enableBorder: enableBorder,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Email')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          enterTextStyle: inputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/email-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'username@gmail.com',
                          border: outlineBorder,
                          hintStyle: hintStyle,
                          focusedBorder: focusBorder,
                          obscureText: null,
                          enableBorder: enableBorder,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Password')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          enterTextStyle: inputStyle,
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
                          border: outlineBorder,
                          hintStyle: hintStyle,
                          focusedBorder: focusBorder,
                          obscureText: isHidden,
                          enableBorder: enableBorder,
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CompleteProfileScreen(),
                          ),
                        ),
                        child: primaryButton(context, 'Signup'),
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
                      Padding(
                        padding: EdgeInsets.only(bottom: 22.0.h),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
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
                                        builder: (context) => LogInScreen(),
                                      ),
                                    );
                                  },
                                text: 'Login',
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
