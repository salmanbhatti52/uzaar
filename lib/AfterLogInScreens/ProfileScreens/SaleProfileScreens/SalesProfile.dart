import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../widgets/TextfromFieldWidget.dart';

class SalesProfile extends StatefulWidget {
  const SalesProfile({super.key});

  @override
  State<SalesProfile> createState() => _SalesProfileState();
}

class _SalesProfileState extends State<SalesProfile> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    addressController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          child: Column(
            children: [
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
              Align(alignment: Alignment.centerLeft, child: text('Last Name')),
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
              Align(alignment: Alignment.centerLeft, child: text('Email')),
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
              Align(alignment: Alignment.centerLeft, child: text('Address')),
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
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  hintText: 'Address',
                  border: outlineBorder,
                  hintStyle: hintStyle,
                  focusedBorder: focusBorder,
                  obscureText: null,
                  enableBorder: enableBorder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
