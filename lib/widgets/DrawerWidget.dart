import 'package:Uzaar/screens/SideMenuScreens/about_us_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/contact_us_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/privacy_policy_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/terms_of_use_screen.dart';

import 'package:Uzaar/screens/SideMenuScreens/settings_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/SideMenuScreens/my_orders_screen.dart';
import '../screens/SideMenuScreens/sales_orders_screen.dart';

class DrawerWidget extends StatefulWidget {
  final BuildContext buildContext;
  const DrawerWidget({super.key, required this.buildContext});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late SharedPreferences sharedPref;
  late String imageUrl;
  removeDataFormSharedPreferences() async {
    await sharedPref.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  Future<String>? getProfile() async {
    imageUrl = '';
    sharedPref = await SharedPreferences.getInstance();
    imageUrl = sharedPref.getString('profile_pic')!;
    print(imageUrl);
    return imageUrl;
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.white,
                // height: 220,
                width: MediaQuery.sizeOf(context).width,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: white,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    // child: CircleAvatar(
                    //   backgroundColor: f5f5f5,
                    // ),
                    child: FutureBuilder<String>(
                      future: getProfile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Show a loading indicator or placeholder while waiting for the image URL
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // Handle error, e.g., display a placeholder or error message
                          return Image.asset('assets/error_image.png');
                        } else {
                          // Load the image using the retrieved URL
                          return CircleAvatar(
                            radius: 5.0, // Adjust the radius as needed
                            backgroundColor: Colors.transparent,
                            backgroundImage: snapshot.data == null
                                ? AssetImage('assets/dummy_profile.png')
                                : NetworkImage(
                                    snapshot.data.toString(),
                                  ) as ImageProvider<Object>?,
                          );
                        }
                      },
                    ),
                    // child: Image.asset(
                    //   'assets/dummy_profile.png',
                    //   fit: BoxFit.scaleDown,
                    // ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                color: white,
                // width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.79,
                child: Column(
                  children: [
                    // profile list

                    ListTile(
                      style: ListTileStyle.drawer,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()
                            // SalesProfileMain(),
                            ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SalesOrdersScreen(),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingScreen(),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermsOfUseScreen(),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen(),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContactUsScreen(),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutUsScreen(),
                        ));
                      },
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
                        removeDataFormSharedPreferences();
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
                    // SizedBox(
                    //   height: 12,
                    // ),
                    SizedBox(
                      height: 50,
                    ),
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
      ),
    );
  }
}
