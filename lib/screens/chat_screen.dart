import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgTextFieldController = TextEditingController();
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                    OtherUserMsgWidget(
                        msgText:
                            'Lorem ipsum dolor sit amet consectetur. Felis luctus eget feugiat nunc urna vestibulum commodo sit.'),
                    SizedBox(
                      height: 14,
                    ),
                    UserMsgWidget(
                      msgText: 'Lorem ipsum dolor sit amet consectetur.',
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    OtherUserMsgWidget(
                      msgText: 'Lorem ipsum dolor sit amet consectetur.',
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    OtherUserMsgWidget(
                      msgText: '\$100 Offer Received',
                      image: Image.asset('assets/offer_img.png'),
                    ),
                    // SizedBox(
                    //   height: 14,
                    // ),
                    // UserMsgWidget(
                    //   msgText: '\$100 Offer Received',
                    //   image: Image.asset('assets/offer_img.png'),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.14),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        // width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.only(left: 20),

                        height: 46,
                        // width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: msgTextFieldController,
                                style: kTextFieldInputStyle,
                                cursorColor: primaryBlue,
                                onTap: () {},
                                onSaved: (newValue) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: white,
                                  hintStyle: kTextFieldHintStyle,
                                  hintText: 'Type here...',
                                  border: InputBorder.none,
                                  // border: kRoundedWhiteBorderStyle,
                                  // enabledBorder: kRoundedWhiteBorderStyle,
                                  // focusedBorder: kRoundedActiveBorderStyle,
                                  contentPadding: EdgeInsets.only(
                                      // left: 15.0,
                                      top: 10.0,
                                      bottom: 13,
                                      right: 10),
                                ),
                              ),
                            ),
                            SvgPicture.asset('assets/attachment_icon.svg'),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset('assets/emoji_icon.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child:
                                    SvgPicture.asset('assets/send_icon.svg')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtherUserMsgWidget extends StatelessWidget {
  const OtherUserMsgWidget({super.key, required this.msgText, this.image});
  final String msgText;
  final Widget? image;

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
              Container(
                margin: image != null ? EdgeInsets.only(bottom: 4) : null,
                child: image,
              ),
              Text(
                msgText,
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
  const UserMsgWidget({super.key, required this.msgText, this.image});

  final String msgText;
  final Widget? image;
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
              Container(
                margin: image != null ? EdgeInsets.only(bottom: 4) : null,
                child: image,
              ),
              Text(
                msgText,
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
