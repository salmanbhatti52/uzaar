import 'package:uzaar/screens/beforeLoginScreens/signup_screen.dart';
import 'package:uzaar/utils/Buttons.dart';
import 'package:uzaar/widgets/alert_dialog_reusable.dart';

import 'package:uzaar/screens/ListingsScreens/listings.dart';

import '../screens/ProfileScreens/PersonalProfileScreens/profile_screen.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/ExploreScreens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/AddListingScreens/add_listing_screen.dart';
import 'package:uzaar/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  static const String id = 'bottom_navbar';
  final bool? loginAsGuest;
  final int requiredScreenIndex;
  final int? requiredListingTypeIndex;
  const BottomNavBar(
      {super.key,
      this.loginAsGuest,
      required this.requiredScreenIndex,
      this.requiredListingTypeIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final List _pages = [
    const HomeScreen(),
    ExploreScreen(),
    const SellScreen(),
    // const ProductAddScreenOne(),
    // const ProductAddScreenTwo(),
    const ListingsScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    print(_currentIndex);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    setState(() {
      _currentIndex = widget.requiredScreenIndex;
      _pages[1] = ExploreScreen(
        requiredListingIndex: widget.requiredListingTypeIndex,
      );
    });
  }

  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    // if (isIos) {
    //   return CupertinoTabScaffold(
    //       tabBar: CupertinoTabBar(
    //         currentIndex: _currentIndex,
    //         height: 75.h,
    //         iconSize: 30,
    //         backgroundColor: white,
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/home-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/home-active.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/explore-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/explore-active.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/add_item_icon.svg'),
    //             activeIcon: SvgPicture.asset('assets/add_item_selected.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/list_item_icon.svg'),
    //             activeIcon: SvgPicture.asset('assets/list_item_selected.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/person-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/profile-active.svg'),
    //             label: '',
    //           ),
    //         ],
    //         onTap: onTap,
    //       ),
    //       tabBuilder: (context, index) {
    //         return CupertinoTabView(
    //           builder: (context) {
    //             return _pages[_currentIndex];
    //           },
    //         );
    //       });
    // } else {
    // return WillPopScope(
    //   onWillPop: () async {
    //     if (_currentIndex == 0) {
    //       return true;
    //     } else {
    //       setState(() {
    //         _currentIndex = 0;
    //       });
    //     }
    //     return false;
    //   },
    // child:
    return Scaffold(
      key: key,
      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: black),
      //     elevation: 0.0,
      //     backgroundColor: Colors.white,
      //     leadingWidth: 70,
      //     leading: Builder(
      //       builder: (context) {
      //         return Padding(
      //           padding: const EdgeInsets.only(top: 8.0, left: 20),
      //           child: GestureDetector(
      //             onTap: () => Scaffold.of(context).openDrawer(),
      //             child: SvgPicture.asset(
      //               'assets/drawer-button.svg',
      //               fit: BoxFit.scaleDown,
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //     actions: [
      //       Padding(
      //         padding: EdgeInsets.only(right: 15.w),
      //         child: Row(
      //           children: [
      //             // Column(
      //             //   children: [
      //             //     Text(
      //             //       'Good Morning!',
      //             //       style: kAppBarTitleStyle,
      //             //     ),
      //             //     Text(
      //             //       'John',
      //             //       style: kAppBarTitleStyle,
      //             //     ),
      //             //   ],
      //             // ),
      //             GestureDetector(
      //               onTap: () => Navigator.of(context).push(
      //                 MaterialPageRoute(
      //                   builder: (context) => MessagesScreen(),
      //                 ),
      //               ),
      //               child: SvgPicture.asset(
      //                 'assets/msg-icon.svg',
      //                 fit: BoxFit.scaleDown,
      //               ),
      //             ),
      //             SizedBox(
      //               width: 15.w,
      //             ),
      //             GestureDetector(
      //               onTap: () => Navigator.of(context).push(
      //                 MaterialPageRoute(
      //                   builder: (context) => NotificationScreen(),
      //                 ),
      //               ),
      //               child: SvgPicture.asset(
      //                 'assets/notification-icon.svg',
      //                 fit: BoxFit.scaleDown,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //     centerTitle: false,
      //     title: _currentIndex == 0
      //         ? Text(
      //             'Home',
      //             style: kAppBarTitleStyle,
      //           )
      //         : _currentIndex == 1
      //             ? Text(
      //                 'Explore',
      //                 style: kAppBarTitleStyle,
      //               )
      //             : _currentIndex == 2
      //                 ? Text(
      //                     'Sell',
      //                     style: kAppBarTitleStyle,
      //                   )
      //                 : _currentIndex == 3
      //                     ? Text(
      //                         'Listings',
      //                         style: kAppBarTitleStyle,
      //                       )
      //                     : Text(
      //                         'Profile',
      //                         style: kAppBarTitleStyle,
      //                       )),
      // drawer: DrawerWidget(
      //   buildContext: context,
      // ),
      body: _currentIndex > 1 && widget.loginAsGuest == true
          ? AlertDialogReusable(
              title: 'Can not Complete Action',
              description:
                  'You can not sell anything on platform in guest mode. Signup now if you want to list any item.',
              button: primaryButton(
                context: context,
                buttonText: 'Signup',
                onTap: () =>
                    Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                )),
                showLoader: false,
              ),
            )
          : _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
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
                icon: SvgPicture.asset('assets/add_item_icon.svg'),
                activeIcon: SvgPicture.asset('assets/add_item_selected.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/list_item_icon.svg'),
                activeIcon: SvgPicture.asset('assets/list_item_selected.svg'),
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
          // Apply box shadow to the ClipRRect
        ),
      ),

      // ),
    );
    // }
  }
}
