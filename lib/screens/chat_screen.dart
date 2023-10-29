import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          'John Doe',
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
              child: Column(
                children: [
                  OtherUserMsgWidget(),
                  SizedBox(
                    height: 14,
                  ),
                  UserMsgWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtherUserMsgWidget extends StatelessWidget {
  const OtherUserMsgWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/other_user_img.png'),
        Container(
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: 214),
          decoration: BoxDecoration(
              color: f7f8f8,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.zero)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem ipsum dolor sit amet consectetur. Felis luctus eget feugiat nunc urna vestibulum commodo sit.',
                style: kTextFieldInputStyle,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '2 min ago',
                style: kFontTwelveFourHG,
              )
            ],
          ),
        )
      ],
    );
  }
}

class UserMsgWidget extends StatelessWidget {
  const UserMsgWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: 214),
          decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.zero,
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem ipsum dolor sit amet consectetur.',
                style: kFontFourteenFourHW,
              ),
              SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '2 min ago',
                  style: kFontTwelveFourHW,
                ),
              )
            ],
          ),
        ),
        Image.asset('assets/user_img.png'),
      ],
    );
  }
}
