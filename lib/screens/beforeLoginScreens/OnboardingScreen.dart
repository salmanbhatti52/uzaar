import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'signup_screen.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'onboarding_screen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController controller;
  bool lastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) => setState(() {
              lastPage = index == 2;
            }),
            controller: controller,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 75.h,
                    ),
                    SvgPicture.asset('assets/onboarding-1.svg'),
                    SizedBox(
                      height: 60.h,
                    ),
                    Text(
                      'Sell Here',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Text(
                      'Have a product or service to sell, list on Elegit. And grow yourself.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: grey,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    SmoothPageIndicator(
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(
                          microseconds: 900,
                        ),
                        curve: Curves.easeInCubic,
                      ),
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primaryBlue,
                        dotColor: grey,
                      ),
                      controller: controller,
                      count: 3,
                    ),
                  ],
                ),
              ), // SCREEN ONE
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    SvgPicture.asset(
                      'assets/onboarding-2.svg',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Text(
                      'Buy Goods or Services',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Text(
                      'Looking for product or services to buy in your area, Elegit links you to sellers in your area.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: grey,
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    SmoothPageIndicator(
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(
                          microseconds: 900,
                        ),
                        curve: Curves.easeInCubic,
                      ),
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                          activeDotColor: primaryBlue,
                          dotColor: grey,
                          spacing: 15),
                      controller: controller,
                      count: 3,
                    ),
                  ],
                ),
              ), //SCREEN TWO
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   height: 75.h,
                    // ),
                    SvgPicture.asset('assets/onboarding-3.svg'),
                    // SizedBox(
                    //   height: 60.h,
                    // ),
                    Text(
                      'Seller Location Verification',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    // SizedBox(
                    //   height: 60.h,
                    // ),
                    Text(
                      'We verify the authenticity of seller to boost confidence of buyers.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: grey,
                      ),
                    ),
                    // SizedBox(
                    //   height: 60.h,
                    // ),
                    SmoothPageIndicator(
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(
                          microseconds: 900,
                        ),
                        curve: Curves.easeInCubic,
                      ),
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primaryBlue,
                        dotColor: grey,
                      ),
                      controller: controller,
                      count: 3,
                    ),

                    primaryButton(
                      context,
                      'Continue',
                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool(
                          'showSignUp',
                          true,
                        );
                        lastPage
                            ? Navigator.pushReplacementNamed(
                                context,
                                SignUpScreen.id,
                              )
                            : controller.nextPage(
                                duration: const Duration(
                                  microseconds: 900,
                                ),
                                curve: Curves.easeInCubic,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
