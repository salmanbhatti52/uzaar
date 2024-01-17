import 'dart:convert';

import 'package:uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/common_list_tile.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<dynamic> chatList = [];
  String errorMessage = '';

  getChatList() async {
    Response response = await sendPostRequest(
        action: 'get_chat_list',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          if (decodedData['data'] != null) {
            chatList = decodedData['data'];
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
    // init();
    getChatList();
  }

  String getMessageDetail(dynamic lastMessage) {
    if (lastMessage is Map<String, dynamic>) {
      return lastMessage['message'] ?? 'No message available';
    } else if (lastMessage is String) {
      // If last_message is a string, use it directly
      return lastMessage;
    }

    // Default message if the format is unexpected
    return 'Unexpected message format';
  }

  // init() async{
  //  await getChatList();
  // }

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
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: RefreshIndicator(
              onRefresh: () async {},
              color: primaryBlue,
              child: chatList.isNotEmpty
                  ? ListView.builder(
                      itemCount: chatList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              otherUserName:
                                  '${chatList[index]['users_customers']['first_name']} ${chatList[index]['users_customers']['last_name']}',
                              otherUserId: chatList[index]['users_customers']
                                  ['users_customers_id'],
                            ),
                          )),
                          child: CommonListTile(
                            imageName: chatList[index]['users_customers']
                                    ['profile_pic'] ??
                                '',
                            title:
                                '${chatList[index]['users_customers']['first_name']} ${chatList[index]['users_customers']['last_name']}',
                            detail: getMessageDetail(
                                chatList[index]['last_message']),
                            duration: chatList[index]['date'],
                          ),
                        );
                      },
                    )
                  : chatList.isEmpty && errorMessage == ''
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!,
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(bottom: 15),
                                        child: const CommonListTileDummy()),
                                  ],
                                ));
                          },
                          itemCount: 4,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true)
                      : chatList.isEmpty && errorMessage != ''
                          ? const Center(
                              child: Text('No chat found.'),
                            )
                          : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
