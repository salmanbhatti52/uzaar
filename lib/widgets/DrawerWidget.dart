import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/screens/ProfileScreens/SaleProfileScreens/SaleProfileMain.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/screens/beforeLoginScreens/LogInScreen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final TextStyle style = GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: black,
    );
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: primaryBlue,
            height: 250.h,
            width: double.infinity,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: white,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 90.h, bottom: 10),
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryBlue,
                    width: 1.5,
                  ),
                  shape: BoxShape.circle,
                  // color: red,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/place-holder.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 32.w,
            ),
            color: white,
            width: double.infinity,
            height: 500.h,
            child: Column(
              children: [
                // profile list
                ListTile(
                  style: ListTileStyle.drawer,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SalesProfileMain(),
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/person-icon.svg',
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Sales Profile',
                    style: style,
                  ),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfileScreen(),
                  //   ),
                  // ),
                  leading: SvgPicture.asset(
                    'assets/order-icon.svg',
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Orders',
                    style: style,
                  ),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfileScreen(),
                  //   ),
                  // ),
                  leading: SvgPicture.asset(
                    'assets/order-icon.svg',
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Sales Orders',
                    style: style,
                  ),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfileScreen(),
                  //   ),
                  // ),
                  leading: SvgPicture.asset(
                    'assets/settings-icon.svg',
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Settings',
                    style: style,
                  ),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ),
                    );
                  },
                  leading: SvgPicture.asset(
                    'assets/logout-icon.svg',
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Logout',
                    style: style,
                  ),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                SizedBox(
                  height: 12.h,
                ),

                Spacer(),
                // log out tile
                ListTile(
                  // onTap: () {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (context) => LogInScreen(),
                  //     ),
                  //   );
                  // },
                  leading: SvgPicture.asset('assets/dlt-icon.svg'),
                  title: Text(
                    'Delete Account',
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
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
    );
  }
}
