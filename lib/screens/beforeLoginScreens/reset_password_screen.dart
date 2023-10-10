import 'package:sellpad/widgets/navigate_back_icon.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';
import 'package:sellpad/widgets/text.dart';

import '../../widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHiddenNew = true;
  bool isHiddenConfirm = true;

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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: NavigateBack(
            buildContext: context,
          ),
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
                      prefixIcon:
                          SvgIcon(imageName: 'assets/password-icon.svg'),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isHiddenNew = !isHiddenNew;
                          });
                        },
                        child: isHiddenNew
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
                      obscureText: isHiddenNew,
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
                    prefixIcon: SvgIcon(imageName: 'assets/password-icon.svg'),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isHiddenConfirm = !isHiddenConfirm;
                        });
                      },
                      child: isHiddenConfirm
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
                    obscureText: isHiddenConfirm,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LogInScreen.id);
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
