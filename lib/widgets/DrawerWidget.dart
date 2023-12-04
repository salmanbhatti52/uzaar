import 'package:Uzaar/screens/SideMenuScreens/about_us_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/contact_us_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/privacy_policy_screen.dart';
import 'package:Uzaar/screens/SideMenuScreens/terms_of_use_screen.dart';

import 'package:Uzaar/screens/SideMenuScreens/settings_screen.dart';
import 'package:Uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/screens/beforeLoginScreens/login_screen.dart';
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

  removeDataFormSharedPreferences() async {
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
        shape: RoundedRectangleBorder(
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
                  ? SizedBox(
                      height: 50,
                    )
                  : DrawerHeader(
                      // padding: EdgeInsets.zero,
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      child: userDataGV['profilePic'] != ''
                          ? CircleAvatar(
                              backgroundColor: Color(0xFFD9D9D9),
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
                              decoration: BoxDecoration(
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
                margin: EdgeInsets.only(left: 40, top: 15),
                // color: white,
                // width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.79,
                child: Column(
                  children: [
                    // profile list
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyOrdersScreen()
                              // SalesProfileMain(),
                              ));
                        },
                        tileImageName: 'order-icon.svg',
                        tileTitle: 'My Orders'),

                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SalesOrdersScreen(),
                        ));
                      },
                      tileImageName: 'order-icon.svg',
                      tileTitle: 'Sales Orders',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SettingScreen(),
                          ));
                        },
                        tileImageName: 'settings-icon.svg',
                        tileTitle: 'Settings'),

                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermsOfUseScreen(),
                        ));
                      },
                      tileImageName: 'terms_of_use_icon.svg',
                      tileTitle: 'Terms of Use',
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen(),
                        ));
                      },
                      tileImageName: 'safety_and_privacy_icon.svg',
                      tileTitle: 'Safety & Privacy',
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactUsScreen(),
                          ));
                        },
                        tileImageName: 'contact_us_icon.svg',
                        tileTitle: 'Contact Us'),

                    SizedBox(
                      height: 15,
                    ),
                    DrawerListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutUsScreen(),
                        ));
                      },
                      tileImageName: 'about_us_icon.svg',
                      tileTitle: 'About Us',
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    DrawerListTile(
                        onTap: () {
                          removeDataFormSharedPreferences();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LogInScreen();
                            },
                          ));
                        },
                        tileImageName: 'logout-icon.svg',
                        tileTitle: 'Logout'),

                    // SizedBox(
                    //   height: 40,
                    // ),
                    Spacer(),

                    ListTile(
                      onTap: null,
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
