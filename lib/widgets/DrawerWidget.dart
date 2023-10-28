import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/screens/ProfileScreens/SaleProfileScreens/SaleProfileMain.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final BuildContext buildContext;
  const DrawerWidget({super.key, required this.buildContext});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  removeDataFormSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        backgroundColor: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.white,
              // height: 220,
              width: double.infinity,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: white,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  // width: 100,
                  // height: 100,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: primaryBlue,
                    //   width: 1.5,
                    // ),
                    shape: BoxShape.circle,
                    // color: red,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/dummy_profile.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 40,
              ),
              color: white,
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.65,
              child: Column(
                children: [
                  // profile list

                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/order-icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'My Orders',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/order-icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Sales Orders',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/settings-icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Settings',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/terms_of_use_icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Terms of Use',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/safety_and_privacy_icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Safety & Privacy',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/contact_us_icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Contact Us',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: SvgPicture.asset(
                      'assets/about_us_icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'About Us',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  ListTile(
                    style: ListTileStyle.drawer,
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LogInScreen();
                        },
                      ));

                      // removeDataFormSharedPreferences();
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(
                      //       builder: (context) => const LogInScreen()),
                      //   (Route<dynamic> route) => false,
                      // );
                    },
                    leading: SvgPicture.asset(
                      'assets/logout-icon.svg',
                      colorFilter:
                          ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Logout',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  Spacer(),
                  // log out tile
                  ListTile(
                    leading: SvgPicture.asset('assets/dlt-icon.svg'),
                    title: Text(
                      'Delete Account',
                      style: kBodyTextStyle,
                    ),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.only(bottom: 20),
                    dense: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
