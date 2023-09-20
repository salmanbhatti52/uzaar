import 'widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LogInScreen.dart';
import 'constants/Buttons.dart';
import 'constants/Colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController newPassController;
  late TextEditingController confirmNewPassController;

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHiddenNew = false;
  bool isHiddenConfirm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newPassController = TextEditingController();
    confirmNewPassController = TextEditingController();
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
      color: grey,
      width: 1,
    ),
  );

  final InputBorder enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: BorderSide(
      color: grey,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'assets/back-arrow-button.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Reset Password',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
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
                    height: 40.h,
                  ),
                  text('New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TextFormFieldWidget(
                      controller: newPassController,
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
                            isHiddenNew = !isHiddenNew;
                          });
                        },
                        child: isHiddenNew
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
                      obscureText: isHiddenNew,
                      enableBorder: enableBorder,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  text('Confirm New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  TextFormFieldWidget(
                    controller: confirmNewPassController,
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
                          isHiddenConfirm = !isHiddenConfirm;
                        });
                      },
                      child: isHiddenConfirm
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
                    obscureText: isHiddenConfirm,
                    enableBorder: enableBorder,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LogInScreen(),
                          ),
                        );
                      },
                      child: primaryButton(context, 'Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
