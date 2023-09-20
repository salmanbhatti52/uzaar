import 'widgets/DrawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AfterLogInScreens/ExploreScreens/ExploreScreen.dart';
import 'AfterLogInScreens/HomeScreen.dart';
import 'AfterLogInScreens/ProfileScreens/ProfileScreen.dart';
import 'AfterLogInScreens/SellScreens/ProductSellScreens/SellScreen.dart';
import 'Constants/Colors.dart';
import 'MessagesScreen.dart';
import 'NotificationScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final List _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const SellScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: _currentIndex,
            height: 75.h,
            iconSize: 30,
            backgroundColor: white,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home-grey.svg'),
                activeIcon: SvgPicture.asset('assets/home-active.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/explore-grey.svg'),
                activeIcon: SvgPicture.asset('assets/explore-active.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/sell-grey.svg'),
                activeIcon: SvgPicture.asset('assets/seel-active.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/person-grey.svg'),
                activeIcon: SvgPicture.asset('assets/profile-active.svg'),
                label: '',
              ),
            ],
            onTap: onTap,
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return _pages[_currentIndex];
              },
            );
          });
    } else {
      return WillPopScope(
        onWillPop: () async {
          if (_currentIndex == 0) {
            return true;
          } else {
            setState(() {
              _currentIndex = 0;
            });
          }
          return false;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: key,
            appBar: AppBar(
              iconTheme: IconThemeData(color: black),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leadingWidth: 70,
              leading: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20),
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: SvgPicture.asset(
                      'assets/drawer-button.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              }),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MessagesScreen(),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/msg-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/notification-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              centerTitle: false,
              title: _currentIndex == 0
                  ? Text(
                      'Home',
                      style: GoogleFonts.syne(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    )
                  : _currentIndex == 1
                      ? Text(
                          'Explore',
                          style: GoogleFonts.syne(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        )
                      : _currentIndex == 2
                          ? Text(
                              'Sell',
                              style: GoogleFonts.syne(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            )
                          : Text(
                              'Profile',
                              style: GoogleFonts.syne(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            ),
            ),
            drawer: DrawerWidget(),
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              mouseCursor: MouseCursor.defer,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/home-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/home-active.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/explore-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/explore-active.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/sell-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/seel-active.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/person-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/profile-active.svg'),
                  label: '',
                ),
              ],
              currentIndex: _currentIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,
              backgroundColor: white,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              iconSize: 30.sp,
            ),
          ),
        ),
      );
    }
  }
}
