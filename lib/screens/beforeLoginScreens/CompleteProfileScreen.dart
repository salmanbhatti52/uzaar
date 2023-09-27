import '../../widgets/TextfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';

import '../../utils/Buttons.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late TextEditingController addressController;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController = TextEditingController();
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

  Widget readOnlyContainer(String objectIcon, String objectText) {
    return Container(
      padding: EdgeInsets.only(left: 13),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: primaryBlue, width: 1),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            objectIcon,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            objectText,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: black,
            ),
          ),
        ],
      ),
    );
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
                              child: SvgPicture.asset(
                                'assets/add-pic-button.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ],
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
                      readOnlyContainer('assets/person-icon.svg', 'First Name'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Last Name')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/person-icon.svg', 'Last Name'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Email')),
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
                          child: text('Phone Number')),
                      SizedBox(
                        height: 7.h,
                      ),
                      readOnlyContainer('assets/phone-fill.svg', '+4156565662'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text('Address')),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormFieldWidget(
                          controller: addressController,
                          textInputType: TextInputType.streetAddress,
                          enterTextStyle: inputStyle,
                          cursorColor: primaryBlue,
                          prefixIcon: SvgPicture.asset(
                            'assets/address-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: SvgPicture.asset(
                            'assets/address-icon.svg',
                            colorFilter:
                                ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Your Address Here',
                          border: outlineBorder,
                          hintStyle: hintStyle,
                          focusedBorder: focusBorder,
                          obscureText: null,
                          enableBorder: enableBorder,
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 25.0.h),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LogInScreen(),
                            ),
                          ),
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
