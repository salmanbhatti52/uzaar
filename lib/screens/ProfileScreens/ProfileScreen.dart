import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/TextfromFieldWidget.dart';
import 'package:Uzaar/widgets/text.dart';

import 'SaleProfileScreens/SaleProfileMain.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                              color: primaryBlue,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/place-holder.png',
                              fit: BoxFit.scaleDown,
                            ),
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
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SalesProfileMain(),
                        ),
                      ),
                      child: Text(
                        'View Sales Profile',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryBlue,
                        ).copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
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
                      child: TextFormFieldWidget(
                        controller: firstNameController,
                        textInputType: TextInputType.name,
                        prefixIcon: SvgPicture.asset(
                          'assets/person-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
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
                        prefixIcon: SvgPicture.asset(
                          'assets/person-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
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
                        prefixIcon: SvgPicture.asset(
                          'assets/email-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
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
                        prefixIcon: SvgPicture.asset(
                          'assets/address-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: SvgPicture.asset(
                          'assets/address-icon.svg',
                          fit: BoxFit.scaleDown,
                          colorFilter:
                              ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                        ),
                        hintText: 'Address',
                        obscureText: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
