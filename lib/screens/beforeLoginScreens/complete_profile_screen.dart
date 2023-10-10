import 'package:sellpad/widgets/suffix_svg_icon.dart';
import 'package:sellpad/widgets/text.dart';

import '../../widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';

import '../../utils/Buttons.dart';
import '../../widgets/read_only_container.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const String id = 'complete_profile_screen';
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

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
          centerTitle: true,
          title: Text(
            'Complete Profile',
            style: kAppBarTitleStyle,
          ),
        ),
        backgroundColor: white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 47.h,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Positioned(
                            right: -10,
                            child: GestureDetector(
                              onTap: null,
                              child: SvgIcon(
                                  imageName: 'assets/add-pic-button.svg'),
                            ),
                          ),
                        ],
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
                      readOnlyContainer('assets/person-icon.svg', 'First Name'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Last Name')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/person-icon.svg', 'Last Name'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Email')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer(
                          'assets/email-icon.svg', 'username@gmail.com'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Phone Number')),
                      SizedBox(
                        height: 7.h,
                      ),
                      // readOnlyContainer('assets/phone-fill.svg', '+4156565662'),
                      TextFormFieldWidget(
                        controller: phoneNumberController,
                        textInputType: TextInputType.phone,
                        prefixIcon: SvgIcon(imageName: 'assets/phone-fill.svg'),
                        hintText: '+4156565662',
                        obscureText: null,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Address')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: addressController,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/address-icon.svg'),
                          suffixIcon: SvgIcon(
                            imageName: 'assets/address-icon.svg',
                            colorFilter:
                                ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                          ),
                          hintText: 'Your Address Here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 25.0.h),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, LogInScreen.id),
                          child: primaryButton(context, 'Continue'),
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
