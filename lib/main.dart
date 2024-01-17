import 'package:uzaar/models/app_data.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzaar/screens/home_screen.dart';
import 'package:uzaar/screens/beforeLoginScreens/login_screen.dart';
import 'package:uzaar/screens/beforeLoginScreens/OnboardingScreen.dart';

import 'package:uzaar/screens/beforeLoginScreens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'screens/custom_splash.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );

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
        theme: ThemeData(useMaterial3: false),
        title: 'uzaar',
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
