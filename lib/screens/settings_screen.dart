import 'package:Uzaar/widgets/common_list_tile.dart';
import 'package:Uzaar/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool orderStatus = true;
  bool reviews = false;
  bool offers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/back-arrow-button.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Settings',
          style: kAppBarTitleStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
          child: Column(
            children: [
              SettingsListTile(
                toggleValue: orderStatus,
                onChanged: (bool value) {
                  setState(() {
                    orderStatus = value;
                  });
                },
                title: 'Order Status',
                detail: 'Get to know when your order status change',
              ),
              SettingsListTile(
                toggleValue: reviews,
                onChanged: (bool value) {
                  setState(() {
                    reviews = value;
                  });
                },
                title: 'Reviews',
                detail: 'Get to know when someone add review',
              ),
              SettingsListTile(
                toggleValue: offers,
                onChanged: (bool value) {
                  setState(() {
                    offers = value;
                  });
                },
                title: 'Offers',
                detail: 'Get to know when someone send offer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
