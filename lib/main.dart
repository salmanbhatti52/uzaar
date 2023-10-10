import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/screens/HomeScreen.dart';
import 'package:sellpad/screens/beforeLoginScreens/complete_profile_screen.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';
import 'package:sellpad/screens/beforeLoginScreens/OnboardingScreen.dart';
import 'package:sellpad/screens/beforeLoginScreens/reset_password_screen.dart';
import 'package:sellpad/screens/beforeLoginScreens/signup_screen.dart';
import 'package:sellpad/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:sellpad/widgets/BottomNaviBar.dart';
import 'screens/CustomSplash.dart';

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
        title: 'Deliver Rider',
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
          BottomNavBar.id: (context) => BottomNavBar()
        },
      ),
    );
  }
}
