import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../services/restService.dart';
import '../widgets/common_list_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notificationsList = [];
  String errorMessage = '';

  getNotifications() async {
    Response response = await sendPostRequest(
        action: 'get_notifications',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          if (decodedData['data'] != null) {
            notificationsList = decodedData['data'];
          } else {
            errorMessage = decodedData['message'];
          }
        });
      }
    }
    if (status == 'error') {
      if (mounted) {
        setState(() {
          errorMessage = decodedData['message'];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
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
          'Notifications',
          style: kAppBarTitleStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: RefreshIndicator(
              onRefresh: () async {},
              color: primaryBlue,
              child: notificationsList.isNotEmpty
                  ? ListView.builder(
                      itemCount: notificationsList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommonListTile(
                          imageName: '',
                          notificationImage: 'assets/notification.png',
                          title: notificationsList[index]['notification_type'],
                          detail: notificationsList[index]['message'],
                          duration: notificationsList[index]['date'],
                        );
                      },
                    )
                  : notificationsList.isEmpty && errorMessage == ''
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: CommonListTileDummy()),
                                  ],
                                ),
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!);
                          },
                          itemCount: 4,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true)
                      : notificationsList.isEmpty && errorMessage != ''
                          ? const Center(
                              child: Text('No notification found.'),
                            )
                          : SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
