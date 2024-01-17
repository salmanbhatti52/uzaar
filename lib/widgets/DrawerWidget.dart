import 'package:uzaar/models/app_data.dart';
import 'package:uzaar/screens/SideMenuScreens/about_us_screen.dart';
import 'package:uzaar/screens/SideMenuScreens/contact_us_screen.dart';
import 'package:uzaar/screens/SideMenuScreens/privacy_policy_screen.dart';
import 'package:uzaar/screens/SideMenuScreens/terms_of_use_screen.dart';

import 'package:uzaar/screens/SideMenuScreens/settings_screen.dart';
import 'package:uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/screens/beforeLoginScreens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/SideMenuScreens/my_orders_screen.dart';
import '../screens/SideMenuScreens/sales_orders_screen.dart';
import 'drawer_list_tile.dart';

class DrawerWidget extends StatefulWidget {
  final BuildContext buildContext;
  const DrawerWidget({super.key, required this.buildContext});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late SharedPreferences sharedPref;

  clearSharedPreferences() async {
    sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              loginAsGuestGV == true
                  ? const SizedBox(
                      height: 50,
                    )
                  : DrawerHeader(
                      // padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      child: userDataGV['profilePic'] != ''
                          ? CircleAvatar(
                              backgroundColor: const Color(0xFFD9D9D9),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  userDataGV['profilePic'],
                                  fit: BoxFit.cover,
                                  height: 135,
                                  width: 135,
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: BoxShape.circle,
                              ),
                            ),
                    ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                    ),
                    color: white),
                margin: const EdgeInsets.only(left: 40, top: 15),
                // color: white,
                // width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.79,
                child: Column(
                  children: [
                    // profile list
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyOrdersScreen()
                              // SalesProfileMain(),
                              ));
                        },
                        tileImageName: 'order-icon.svg',
                        tileTitle: 'My Orders'),

                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SalesOrdersScreen(),
                        ));
                      },
                      tileImageName: 'order-icon.svg',
                      tileTitle: 'Sales Orders',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingScreen(),
                          ));
                        },
                        tileImageName: 'settings-icon.svg',
                        tileTitle: 'Settings'),

                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TermsOfUseScreen(),
                        ));
                      },
                      tileImageName: 'terms_of_use_icon.svg',
                      tileTitle: 'Terms of Use',
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ));
                      },
                      tileImageName: 'safety_and_privacy_icon.svg',
                      tileTitle: 'Safety & Privacy',
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ));
                        },
                        tileImageName: 'contact_us_icon.svg',
                        tileTitle: 'Contact Us'),

                    const SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ));
                      },
                      tileImageName: 'about_us_icon.svg',
                      tileTitle: 'About Us',
                    ),

                    const SizedBox(
                      height: 35,
                    ),
                    DrawerListTile(
                        onTap: () {
                          clearSharedPreferences();
                          Provider.of<AppData>(context, listen: false)
                              .clearData();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const LogInScreen();
                            },
                          ));
                        },
                        tileImageName: 'logout-icon.svg',
                        tileTitle: 'Logout'),

                    // SizedBox(
                    //   height: 40,
                    // ),
                    const Spacer(),

                    ListTile(
                      onTap: null,
                      leading: SvgPicture.asset('assets/dlt-icon.svg'),
                      title: Text(
                        'Delete Account',
                        style: kBodyTextStyle,
                      ),
                      visualDensity: VisualDensity.compact,
                      contentPadding: const EdgeInsets.only(bottom: 20),
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
