import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../services/restService.dart';
import '../widgets/message_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.otherUserId, required this.otherUserName});
  final int otherUserId;
  final String otherUserName;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgTextFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> messages = [];
  String chatHistoryStatus = '';
  late Timer _timer;

  Future<String> sendMessage() async {
    String message = msgTextFieldController.text.toString();
    msgTextFieldController.clear();

    setState(() {
      messages.add({
        'sender_id': userDataGV['userId'],
        'date': 'Today',
        'users_customers': {
          'profile_pic': userDataGV['profilePathUrl'],
        },
        'message': message
      });
    });

    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'sendMessage',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.otherUserId,
      'message_type': 'text',
      'message': message
    });

    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    return status;
  }

  getMessages() async {
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'getMessages',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.otherUserId,
    });
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    chatHistoryStatus = status;
    if (status == 'success') {
      if (mounted) {
        setState(() {
          if (decodedData['data'].length > messages.length) {
            messages = decodedData['data'];
          }
        });
      }
    }
  }

  callRepeatingFunction() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getMessages();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages();
    callRepeatingFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // if (_timer.isActive) {
    _timer.cancel();
    // }
    super.dispose();
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
          widget.otherUserName,
          style: kAppBarTitleStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
          child: RefreshIndicator(
            onRefresh: () async {},
            color: primaryBlue,
            child: Column(
              children: [
                Expanded(
                  // child: ListView(
                  // children: [
                  //
                  //
                  // OtherUserMsgWidget(
                  //   msgText: '\$100 Offer Received',
                  //   image: Image.asset('assets/offer_img.png'),
                  // ),
                  // SizedBox(
                  //   height: 14,
                  // ),
                  // UserMsgWidget(
                  //   msgText: '\$100 Offer Received',
                  //   image: Image.asset('assets/offer_img.png'),
                  // ),
                  // ],
                  // ),
                  child: messages.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            int reverse = messages.length - 1 - index;
                            return messages[reverse]['sender_id'] ==
                                    userDataGV['userId']
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: UserMsgWidget(
                                        date: messages[reverse]['date'],
                                        networkImagePath: messages[reverse]
                                            ['users_customers']['profile_pic'],
                                        msgText: messages[reverse]['message']),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: OtherUserMsgWidget(
                                        date: messages[reverse]['date'],
                                        networkImagePath: messages[reverse]
                                            ['users_customers']['profile_pic'],
                                        msgText: messages[reverse]['message']),
                                  );
                          },
                          controller: _scrollController,
                          reverse: true,
                          itemCount: messages.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true)
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: UserMsgWidgetDummy()),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: OtherUserMsgWidgetDummy())
                                  ],
                                ),
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!);
                          },
                          itemCount: 3,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true),
                ),
                SizedBox(
                  height: 20,
                ),
                MessageTextField(
                  msgTextFieldController: msgTextFieldController,
                  sendButtonTap: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherUserMsgWidget extends StatelessWidget {
  const OtherUserMsgWidget(
      {super.key,
      required this.msgText,
      this.image,
      required this.networkImagePath,
      required this.date});
  final String msgText;
  final Widget? image;
  final String networkImagePath;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFFD9D9D9),
          maxRadius: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              imgBaseUrl + networkImagePath,
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.all(10),
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
              Container(
                constraints: BoxConstraints(maxWidth: 215),
                child: Text(
                  msgText,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: kTextFieldInputStyle,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              image == null
                  ? Text(
                      date,
                      style: kFontTwelveFourHG,
                    )
                  : SizedBox()
            ],
          ),
        )
      ],
    );
  }
}

class OtherUserMsgWidgetDummy extends StatelessWidget {
  const OtherUserMsgWidgetDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.3),
          maxRadius: 12,
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 150),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.zero)),
        )
      ],
    );
  }
}

class UserMsgWidget extends StatelessWidget {
  const UserMsgWidget(
      {super.key,
      required this.msgText,
      this.image,
      required this.networkImagePath,
      required this.date});

  final String msgText;
  final Widget? image;
  final String networkImagePath;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.all(10),
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
              Container(
                constraints: BoxConstraints(maxWidth: 214),
                child: Text(
                  msgText,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: kFontFourteenFourHW,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              image == null
                  ? Text(
                      date,
                      style: kFontTwelveFourHW,
                    )
                  : SizedBox()
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFD9D9D9),
          maxRadius: 12,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                imgBaseUrl + networkImagePath,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }
}

class UserMsgWidgetDummy extends StatelessWidget {
  const UserMsgWidgetDummy({
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
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 150),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.zero,
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14))),
        ),
        CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.3),
          maxRadius: 12,
        )
      ],
    );
  }
}
