import 'dart:convert';

import 'package:Uzaar/widgets/settings_list_tile.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../services/restService.dart';
import '../../utils/Colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showSpinner = false;
  bool orderStatus = true;
  bool reviews = false;
  bool offers = false;

  updateOrderStatus() async {
    setState(() {
      showSpinner = true;
    });
    Response response =
        await sendPostRequest(action: 'update_switch_order_status', data: {
      'users_customers_id': userDataGV['userId'].toString(),
      'order_status': orderStatus ? 'ON' : 'OFF'
    });
    setState(() {
      showSpinner = false;
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];

    if (status == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SuccessSnackBar(message: null));
      // ignore: use_build_context_synchronously
    }
    if (status == 'error') {
      String message = decodedResponse['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: message));
    }
  }

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
          child: ModalProgressHUD(
            color: Colors.white,
            dismissible: true,
            inAsyncCall: showSpinner,
            child: Column(
              children: [
                SettingsListTile(
                  toggleValue: orderStatus,
                  onChanged: (bool value) async {
                    setState(() {
                      orderStatus = value;
                    });
                    print('orderStatus: $orderStatus');
                    updateOrderStatus();
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
                    print('reviews: $reviews');
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
                    print('offers: $offers');
                  },
                  title: 'Offers',
                  detail: 'Get to know when someone send offer',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
