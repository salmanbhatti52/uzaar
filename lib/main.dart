import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/HomeScreen.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_one.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_two.dart';
import 'package:Uzaar/screens/beforeLoginScreens/complete_profile_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/LogInScreen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/OnboardingScreen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/reset_password_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/signup_screen.dart';
import 'package:Uzaar/screens/beforeLoginScreens/verify_email_screen.dart';
import 'package:Uzaar/widgets/BottomNaviBar.dart';
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
          BottomNavBar.id: (context) => BottomNavBar(),
          // ProductAddScreenOne.id: (context) => ProductAddScreenOne(),
          // ProductAddScreenTwo.id: (context) => ProductAddScreenTwo(),
        },
      ),
    );
  }
}
