import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/TextfromFieldWidget.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:Uzaar/widgets/text.dart';

class SalesProfile extends StatefulWidget {
  const SalesProfile({super.key});

  @override
  State<SalesProfile> createState() => _SalesProfileState();
}

class _SalesProfileState extends State<SalesProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                child: ReusableText(text: 'First Name'),
              ),
              SizedBox(
                height: 7.h,
              ),
              SizedBox(
                height: 50.h,
                child: TextFormFieldWidget(
                  controller: firstNameController,
                  textInputType: TextInputType.name,
                  prefixIcon: SvgIcon(imageName: 'assets/person-icon.svg'),
                  hintText: 'First Name',
                  obscureText: null,
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
                child: TextFormFieldWidget(
                  controller: lastNameController,
                  textInputType: TextInputType.name,
                  prefixIcon: SvgIcon(imageName: 'assets/person-icon.svg'),
                  hintText: 'Last Name',
                  obscureText: null,
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
                  child: ReusableText(text: 'Address')),
              SizedBox(
                height: 7.h,
              ),
              SizedBox(
                height: 50.h,
                child: TextFormFieldWidget(
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  prefixIcon: SvgIcon(imageName: 'assets/address-icon.svg'),
                  suffixIcon: SvgIcon(
                    imageName: 'assets/address-icon.svg',
                    colorFilter:
                        const ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  hintText: 'Address',
                  obscureText: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
