import 'package:flutter/material.dart';
import 'package:sellpad/screens/beforeLoginScreens/OnboardingScreen.dart';

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

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        Navigator.pushReplacementNamed(
          context,
          OnBoardingScreen.id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            'assets/Splash.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
