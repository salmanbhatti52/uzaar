import 'package:Uzaar/screens/home_screen.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Uzaar/screens/beforeLoginScreens/OnboardingScreen.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';

class CustomSplash extends StatefulWidget {
  static const String id = 'custom_splash';
  const CustomSplash({Key? key}) : super(key: key);

  @override
  State<CustomSplash> createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  // late SecureSharedPref secureSharedPref;
  // String isLogin = 'false';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // secureSharedPref = await SecureSharedPref.getInstance();
    // isLogin = (await secureSharedPref.getString('isLogin')) ?? 'false';

    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () async {
    //     Navigator.pushReplacementNamed(
    //       context,
    //       OnBoardingScreen.id,
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: grey,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              SizedBox(
                height: 280,
                width: 180,
                child: SvgPicture.asset(
                  'assets/splash_logo.svg',
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, BottomNavBar.id
                      // OnBoardingScreen.id,
                      );
                },
                child: SizedBox(
                  height: 70,
                  width: 189,
                  child: SvgIcon(
                    imageName: 'assets/splash_button.svg',
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
