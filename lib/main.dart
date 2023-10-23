import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/home_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/complete_profile_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/logIn_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/OnboardingScreen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/reset_password_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/signup_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
import 'screens/custom_splash.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
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
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Uzaar',
        // home: CustomSplash(),
        initialRoute: CustomSplash.id,
        routes: {
          CustomSplash.id: (context) => CustomSplash(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          VerifyEmail.id: (context) => VerifyEmail(),
          CompleteProfileScreen.id: (context) => CompleteProfileScreen(),
          LogInScreen.id: (context) => LogInScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
          BottomNavBar.id: (context) => BottomNavBar(
                loginAsGuest: false,
              ),
          // ProductAddScreenOne.id: (context) => ProductAddScreenOne(),
          // ProductAddScreenTwo.id: (context) => ProductAddScreenTwo(),
        },
      ),
    );
  }
}
