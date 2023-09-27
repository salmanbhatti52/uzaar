import 'package:sellpad/widgets/navigate_back_icon.dart';
import 'package:sellpad/widgets/text.dart';

import '../../widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: NavigateBack(),
          centerTitle: true,
          title: Text('Reset Password', style: kAppBarTitleStyle),
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
                    height: 50.h,
                  ),
                  ReusableText(text: 'New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TextFormFieldWidget(
                      controller: newPassController,
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
                      border: kRoundedBorderStyle,
                      hintStyle: kTextFieldHintStyle,
                      focusedBorder: kRoundedBorderStyle,
                      obscureText: isHiddenNew,
                      enableBorder: kRoundedBorderStyle,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableText(text: 'Confirm New Password'),
                  SizedBox(
                    height: 7.h,
                  ),
                  TextFormFieldWidget(
                    controller: confirmNewPassController,
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
                    border: kRoundedBorderStyle,
                    hintStyle: kTextFieldHintStyle,
                    focusedBorder: kRoundedBorderStyle,
                    obscureText: isHiddenConfirm,
                    enableBorder: kRoundedBorderStyle,
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
