import 'dart:convert';

import 'package:Uzaar/widgets/settings_list_tile.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/restService.dart';
import '../../utils/Colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showSpinner = false;
  bool orderStatus = false;
  bool reviewsToggleVal = false;
  bool offersToggleVal = false;
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      orderStatus = userDataGV['orderStatus'] ?? false;
      reviewsToggleVal = userDataGV['reviewsToggleVal'] ?? false;
      offersToggleVal = userDataGV['offersToggleVal'] ?? false;
    });
  }

  toggleOrderStatus() async {
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
      // update for sharedPreferences
      await preferences.setBool('order_status', orderStatus);
      print('orderStatus: $orderStatus');
      print(
          'orderStatus from preferences:  ${preferences.getBool('order_status')}');
      // update for Global variable
      userDataGV['orderStatus'] = orderStatus;
      // ignore: use_build_context_synchronously
    }
    if (status == 'error') {
      String message = decodedResponse['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: message));
    }
  }

  toggleReviews() async {
    setState(() {
      showSpinner = true;
    });
    Response response =
        await sendPostRequest(action: 'update_switch_reviews', data: {
      'users_customers_id': userDataGV['userId'].toString(),
      'reviews': reviewsToggleVal ? 'ON' : 'OFF'
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
      // update for sharedPreferences
      await preferences.setBool('reviews_status', reviewsToggleVal);
      print('reviewsToggleVal: $reviewsToggleVal');
      print(
          'reviewsToggleVal from preferences:  ${preferences.getBool('reviews_status')}');
      // update for Global variable
      userDataGV['reviewsToggleVal'] = reviewsToggleVal;
      // ignore: use_build_context_synchronously
    }
    if (status == 'error') {
      String message = decodedResponse['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: message));
    }
  }

  toggleOffers() async {
    setState(() {
      showSpinner = true;
    });
    Response response =
        await sendPostRequest(action: 'update_switch_offers', data: {
      'users_customers_id': userDataGV['userId'].toString(),
      'offers': offersToggleVal ? 'ON' : 'OFF'
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
      // update for sharedPreferences
      await preferences.setBool('offers_status', offersToggleVal);
      print('offersToggleVal: $offersToggleVal');
      print(
          'offersToggleVal from preferences:  ${preferences.getBool('offers_status')}');
      // update for Global variable
      userDataGV['offersToggleVal'] = offersToggleVal;
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
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
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
                    toggleOrderStatus();
                  },
                  title: 'Order Status',
                  detail: 'Get to know when your order status change',
                ),
                SettingsListTile(
                  toggleValue: reviewsToggleVal,
                  onChanged: (bool value) {
                    setState(() {
                      reviewsToggleVal = value;
                    });
                    print('reviews: $reviewsToggleVal');
                    toggleReviews();
                  },
                  title: 'Reviews',
                  detail: 'Get to know when someone add review',
                ),
                SettingsListTile(
                  toggleValue: offersToggleVal,
                  onChanged: (bool value) {
                    setState(() {
                      offersToggleVal = value;
                    });
                    print('offers: $offersToggleVal');
                    toggleOffers();
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
