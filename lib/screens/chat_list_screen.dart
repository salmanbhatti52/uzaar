import 'package:Uzaar/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';

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
          'Chats',
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
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    )),
                    child: CommonListTile(
                      imageName: 'assets/chat_image.png',
                      title: 'John Doe',
                      detail: 'Lorem ipsum dolor sit amet consectetur.',
                      duration: '2 min ago',
                    ),
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