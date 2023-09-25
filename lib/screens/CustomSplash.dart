import 'package:flutter/material.dart';
import 'package:sellpad/screens/beforeLoginScreens/OnboardingScreen.dart';

class CustomSplash extends StatefulWidget {
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
      const Duration(seconds: 3),
      () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //pushReplacement = replacing the route so that
            //splash screen won't show on back button press
            //navigation to Home page.
            // builder: (context) {
            //   return isLogin == "true"
            //       ? const BottomNavigationBarScreens()
            //       : const OnBoardingScreens();
            // },
            builder: (context) {
              return const OnBoardingScreen();
            },
          ),
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
