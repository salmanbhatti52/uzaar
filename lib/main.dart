import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/home_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/OnboardingScreen.dart';

import 'package:Uzaar/screens/beforeLoginScreens/signup_screen.dart';

import 'screens/custom_splash.dart';

void main() {
  runApp(const MyApp());

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Uzaar',
        // home: CustomSplash(),
        initialRoute: CustomSplash.id,
        routes: {
          CustomSplash.id: (context) => const CustomSplash(),
          OnBoardingScreen.id: (context) => const OnBoardingScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          // VerifyEmail.id: (context) => VerifyEmail(),
          // CompleteProfileScreen.id: (context) => CompleteProfileScreen(),
          LogInScreen.id: (context) => const LogInScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          // ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
          // BottomNavBar.id: (context) => BottomNavBar(
          //       loginAsGuest: false,
          //     ),
          // ProductAddScreenOne.id: (context) => ProductAddScreenOne(),
          // ProductAddScreenTwo.id: (context) => ProductAddScreenTwo(),
        },
      ),
    );
  }
}
