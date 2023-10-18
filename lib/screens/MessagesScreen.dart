import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/Colors.dart';

import '../widgets/common_list_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/back-arrow-button.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Chats',
          style: kAppBarTitleStyle,
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 13),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: RefreshIndicator(
              onRefresh: () async {},
              color: primaryBlue,
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CommonListTile(
                    imageName: 'assets/chatImage1.svg',
                    title: 'John Doe',
                    detail: 'Lorem ipsum dolor sit amet consectetur.',
                    duration: '2 min ago',
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
