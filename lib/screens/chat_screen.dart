import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:uzaar/screens/BusinessDetailPages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../services/getImage.dart';
import '../services/restService.dart';
import '../widgets/message_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../widgets/ohter_user_msg_widget.dart';
import '../widgets/user_msg_widget.dart';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'BeforeLoginScreens/add_image_screen.dart';

const accentColor = Color(0xFF4BA586);
const accentColorDark = Color(0xFF377E6A);
const backgroundColor = Color(0xFFEEE7DF);
const secondaryColor = Color(0xFF8B98A0);
const systemBackgroundColor = Color(0xFFF7F8FA);

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.otherUserId,
      required this.otherUserName,
      this.typeOfChat,
      this.offerData});
  final int otherUserId;
  final String otherUserName;
  final String? typeOfChat;
  final Map? offerData;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgTextFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> messages = [];
  String chatHistoryStatus = '';
  Timer? _timer;
  String errorMessage = '';
  String selectedImageInBase64 = '';
  Map<String, dynamic> images = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('chatType: ${widget.typeOfChat}');
    getMessages();
    callRepeatingFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose called');
    _timer?.cancel();
    print('dispose called 2');
    super.dispose();
  }

  callRepeatingFunction() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      getMessages();
    });
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });

      // Format the date using intl package
      final formattedDate = DateFormat.yMMMd().format(selectedDate!);

      print(formattedDate); // Output: Feb 20, 2024
      setState(() {
        msgTextFieldController.text =
            msgTextFieldController.text + formattedDate;
      });
    }
  }

  Future<String> sendMessage() async {
    String message = msgTextFieldController.text.toString();
    String messageType = '';
    String caption = '';
    msgTextFieldController.clear();

    if (selectedImageInBase64.isEmpty) {
      messageType = 'text';
    } else if (selectedImageInBase64.isNotEmpty && message.isEmpty) {
      messageType = 'attachment';
      message = selectedImageInBase64;
      selectedImageInBase64 = '';
    } else if (selectedImageInBase64.isNotEmpty && message.isNotEmpty) {
      messageType = 'other';
      caption = message;
      message = selectedImageInBase64;
      selectedImageInBase64 = '';
    } else {}
    setState(() {
      messages.add({
        'sender_id': userDataGV['userId'],
        'date': 'Today',
        'users_customers': {
          'profile_pic': userDataGV['profilePathUrl'],
        },
        'message':
            messageType != 'text' ? images['image']['imageInXFile'] : message,
        'message_type': messageType != 'text' ? 'base64string' : messageType,
        'caption': caption
      });
      images = {};
    });

    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'sendMessage',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.otherUserId,
      'message_type': messageType,
      'message': message,
      "caption": caption
    });

    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    // setState(() {
    //   if (isEmojiVisible == true) {
    //     isEmojiVisible = false;
    //   }
    // });
    return status;
  }

  getMessages() async {
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'getMessages',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.otherUserId,
    });
    // print(response.statusCode);
    // print('messages: ${response.body}');
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
    if (status == 'error') {
      if (mounted) {
        setState(() {
          errorMessage = decodedData['message'];
        });
      }
    }
  }

  bool isEmojiVisible = false;

  void toggleEmojiPicker() {
    setState(() {
      FocusScope.of(context).unfocus();
      isEmojiVisible = !isEmojiVisible;
      if (!isEmojiVisible) {
        _focusNode.requestFocus();
      }
    });
  }

  closeEmojiKeyboard() {
    setState(() {
      if (isEmojiVisible == true) {
        isEmojiVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!isEmojiVisible) {
          Navigator.of(context).pop();
        } else {
          setState(() {
            isEmojiVisible = false;
          });
        }
        // _timer.cancel();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (isEmojiVisible == true) {
            setState(() {
              isEmojiVisible = false;
            });
          }
        },
        child: Scaffold(
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
            actions: [
              widget.typeOfChat == 'shipping'
                  ? GestureDetector(
                      onTap: () {
                        _timer?.cancel();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return PaymentScreen(
                              buyTheProduct: true,
                              buyTheBoosting: false,
                              offerData: widget.offerData,
                            );
                          },
                        ));
                      },
                      child: SizedBox(
                        height: 27,
                        child: Container(
                          width: 80,
                          height: 27,
                          margin: const EdgeInsets.fromLTRB(0, 14, 12, 9),
                          decoration: BoxDecoration(
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            'Pay Now',
                            style: kFontThirteenFiveHW,
                          )),
                        ),
                      ),
                    )
                  : widget.typeOfChat == 'meetup'
                      ?
                      // Column(
                      //   children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 14, 12, 9),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  // height: 27,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Meet-up',
                                      style: kFontThirteenFiveHW,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: const Icon(
                                    Icons.calendar_month,
                                    color: primaryBlue,
                                  ))
                            ],
                          ),
                        )
                      : const SizedBox(),
              // Text(
              //   selectedDate != null
              //       ? '${selectedDate.toString().split(' ')[0]}'
              //       : 'Select Date',
              //   style: TextStyle(
              //     color: selectedDate != null
              //         ? Colors.black
              //         : Color.fromRGBO(167, 169, 183, 1),
              //     fontFamily: "Outfit",
              //     fontWeight: FontWeight.w300,
              //     fontSize: 14,
              //   ),
              // ),
              // ],
              // )
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
              child: RefreshIndicator(
                onRefresh: () async {},
                color: primaryBlue,
                child: Column(
                  children: [
                    widget.typeOfChat == 'meetup'
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.red,
                                    width: 1.5,
                                    style: BorderStyle.solid)),
                            margin: const EdgeInsets.only(bottom: 17),
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Now that you want to meet up for this transaction, we advise that you take the following precautions:\n\n'
                              '1. Meet up in a public location\n'
                              '2. Make the exchange only when you are satisfied with the condition of the item\n'
                              '3. Use respectful language.',
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      child: messages.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                int reverse = messages.length - 1 - index;
                                return messages[reverse]['sender_id'] ==
                                        userDataGV['userId']
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: UserMsgWidget(
                                            date: messages[reverse]['date'],
                                            networkImagePath: messages[reverse]
                                                        ['users_customers']
                                                    ['profile_pic'] ??
                                                '',
                                            msgText: messages[reverse]
                                                        ['message_type'] ==
                                                    'text'
                                                ? messages[reverse]['message']
                                                : messages[reverse]
                                                            ['message_type'] ==
                                                        'attachment'
                                                    ? ''
                                                    : messages[reverse]['message_type'] ==
                                                            'other'
                                                        ? messages[reverse]
                                                            ['caption']
                                                        : messages[reverse]
                                                            ['caption'],
                                            image: messages[reverse]
                                                        ['message_type'] ==
                                                    'attachment'
                                                ? ChatImage(
                                                    imagePath: imgBaseUrl +
                                                        messages[reverse]['message'])
                                                : messages[reverse]['message_type'] == 'other'
                                                    ? ChatImage(imagePath: imgBaseUrl + messages[reverse]['message'])
                                                    : messages[reverse]['message_type'] == 'base64string'
                                                        ? TempImage(imagePath: File(messages[reverse]['message'].path))
                                                        : const SizedBox()),
                                      )
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: OtherUserMsgWidget(
                                          date: messages[reverse]['date'],
                                          networkImagePath: messages[reverse]
                                                      ['users_customers']
                                                  ['profile_pic'] ??
                                              '',
                                          msgText: messages[reverse]
                                                      ['message_type'] ==
                                                  'text'
                                              ? messages[reverse]['message']
                                              : messages[reverse]
                                                          ['message_type'] ==
                                                      'attachment'
                                                  ? ''
                                                  : messages[reverse][
                                                              'message_type'] ==
                                                          'other'
                                                      ? messages[reverse]
                                                          ['caption']
                                                      : '',
                                          image: messages[reverse]
                                                      ['message_type'] ==
                                                  'attachment'
                                              ? ChatImage(
                                                  imagePath: imgBaseUrl +
                                                      messages[reverse]
                                                          ['message'])
                                              : messages[reverse]
                                                          ['message_type'] ==
                                                      'other'
                                                  ? ChatImage(
                                                      imagePath: imgBaseUrl +
                                                          messages[reverse]
                                                              ['message'])
                                                  : const SizedBox(),
                                        ),
                                      );
                              },
                              controller: _scrollController,
                              reverse: true,
                              itemCount: messages.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true)
                          : messages.isEmpty && errorMessage == ''
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                        baseColor: Colors.grey[500]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Column(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                                child:
                                                    const UserMsgWidgetDummy()),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                                child:
                                                    const OtherUserMsgWidgetDummy())
                                          ],
                                        ));
                                  },
                                  itemCount: 3,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true)
                              : messages.isEmpty && errorMessage != ''
                                  ? const Center(
                                      child: Text('No message found.'),
                                    )
                                  : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    images.isNotEmpty
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 94,
                              width: 94,
                              margin: EdgeInsets.only(bottom: 9, left: 6),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1,
                                      color: primaryBlue,
                                      style: BorderStyle.solid)),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 94,
                                    width: 94,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          File(images['image']['imageInXFile']
                                              .path),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                      top: 6,
                                      right: 6,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            images = {};
                                            selectedImageInBase64 = '';
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/remove.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    MessageTextField(
                      focusNode: _focusNode,
                      isEmojiShowing: isEmojiVisible,
                      onEmojiButtonTap: toggleEmojiPicker,
                      onTap: closeEmojiKeyboard,
                      onAttachmentButtonTap: () async {
                        var result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: const AddImageScreen()),
                          ),
                        );
                        print(result);
                        if (result == 'camera') {
                          images = await getImage(from: 'camera');
                          if (images.isNotEmpty) {
                            setState(() {
                              selectedImageInBase64 =
                                  images['image']['imageInBase64'];
                            });
                          }
                        }
                        if (result == 'gallery') {
                          images = await getImage(from: 'gallery');
                          if (images.isNotEmpty) {
                            setState(() {
                              selectedImageInBase64 =
                                  images['image']['imageInBase64'];
                            });
                          }
                        }
                      },
                      msgTextFieldController: msgTextFieldController,
                      sendButtonTap: () {
                        if (msgTextFieldController.text.isNotEmpty ||
                            selectedImageInBase64.isNotEmpty) {
                          sendMessage();
                        }
                      },
                    ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    if (isEmojiVisible)
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: primaryBlue,
                                style: BorderStyle.solid,
                                width: 1.5)),
                        // height: 237,
                        child: EmojiPicker(
                          onEmojiSelected: (Category? category, Emoji? emoji) {
                            // Do something when emoji is tapped (optional)
                          },
                          onBackspacePressed: () {
                            // Do something when the user taps the backspace button (optional)
                            // Set it to null to hide the Backspace-Button
                          },
                          textEditingController:
                              msgTextFieldController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                          config: Config(
                            height: 240,
                            // bgColor: const Color(0xFFF2F2F2),
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                                noRecents: const Text('No Recents',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black26),
                                    textAlign: TextAlign.center),
                                backgroundColor: f5f5f5,
                                columns: 7,
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 28 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.20
                                        : 1.0),
                                loadingIndicator: SizedBox.shrink()),
                            swapCategoryAndBottomBar: true,
                            // skinToneConfig: const SkinToneConfig(dialogBackgroundColor: Colors.red,indicatorColor: Colors.red,enabled: false),
                            categoryViewConfig: const CategoryViewConfig(
                              indicatorColor: primaryBlue,
                              backgroundColor: f5f5f5,
                              iconColor: grey,
                              iconColorSelected: primaryBlue,
                            ),
                            bottomActionBarConfig: const BottomActionBarConfig(
                                backgroundColor: f5f5f5,
                                buttonColor: f5f5f5,
                                buttonIconColor: grey),
                            searchViewConfig: const SearchViewConfig(
                              buttonIconColor: grey,
                              buttonColor: Colors.white,
                              backgroundColor: f5f5f5,
                            ),
                          ),
                        ),
                      ),
                    // SizedBox(
                    //   height: 12,
                    // ),
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

class ChatImage extends StatelessWidget {
  const ChatImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.zero,
        bottomLeft: Radius.circular(14),
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PhotoImageView(imagePath: imagePath);
              },
            ));
          },
          child: Image.network(imagePath,
              height: 184, width: 160, fit: BoxFit.cover)),
    );
  }
}

class TempImage extends StatelessWidget {
  const TempImage({Key? key, required this.imagePath}) : super(key: key);
  final File imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.zero,
        bottomLeft: Radius.circular(14),
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      child: GestureDetector(onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return PhotoImageView(fileImagePath: imagePath);
          },
        ));
      }, child: Image.file(imagePath, height: 184, width: 160, fit: BoxFit.cover)),
    );
  }
}

class PhotoImageView extends StatefulWidget {
  final String? imagePath;
  final File? fileImagePath;
  const PhotoImageView({Key? key, this.imagePath, this.fileImagePath})
      : super(key: key);

  @override
  State<PhotoImageView> createState() => _PhotoImageViewState();
}

class _PhotoImageViewState extends State<PhotoImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: widget.fileImagePath == null? PhotoView(
              imageProvider: NetworkImage(widget.imagePath!),
            ):PhotoView(
              imageProvider: FileImage(widget.fileImagePath!),
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.sizeOf(context).width,
          //   height: MediaQuery.sizeOf(context).height,
          //   child: PhotoView(
          //     imageProvider: FileImage(widget.fileImagePath!),
          //   ),
          // ),
        ],
      ),
    );
  }
}
