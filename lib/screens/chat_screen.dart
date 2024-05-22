import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uzaar/screens/BusinessDetailPages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../services/getImage.dart';
import '../services/restService.dart';
import '../widgets/message_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../widgets/ohter_user_msg_widget.dart';
import '../widgets/snackbars.dart';
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
  late final EmojiTextEditingController msgTextFieldController;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> messages = [];
  String chatHistoryStatus = '';
  late Timer _timer;
  String errorMessage = '';
  String selectedImageInBase64 = '';
  Map<String, dynamic> images = {};

// ============= emoji code ========================
  final _utils = EmojiPickerUtils();
  late final FocusNode _focusNode;
  late final TextStyle _textStyle;
  final bool isApple = [TargetPlatform.iOS, TargetPlatform.macOS]
      .contains(foundation.defaultTargetPlatform);
  bool _emojiShowing = false;

  // ====================done=======================

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('chatType: ${widget.typeOfChat}');
    getMessages();
    callRepeatingFunction();

    // ============= emoji code ========================
    final fontSize = 20 * (isApple ? 1.2 : 1.0);
    // Define Custom Emoji Font & Text Style
    _textStyle = DefaultEmojiTextStyle.copyWith(
      // fontFamily: GoogleFonts.notoColorEmoji().fontFamily,
      fontSize: fontSize,
    );

    msgTextFieldController =
        EmojiTextEditingController(emojiTextStyle: _textStyle);
    _focusNode = FocusNode();

    // ====================done=======================
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose called');
    _timer.cancel();
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
      images = {};
      // messages.add({
      //   'sender_id': userDataGV['userId'],
      //   'date': 'Today',
      //   'users_customers': {
      //     'profile_pic': userDataGV['profilePathUrl'],
      //   },
      //   'message': message
      // });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_emojiShowing) {
          setState(() {
            _emojiShowing = false;
          });
        } else {
          Navigator.of(context).pop();
          // print(_emojiShowing);
          // print('called');
        }

        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
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
                        _timer.cancel();
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
                                                    : messages[reverse][
                                                                'message_type'] ==
                                                            'other'
                                                        ? messages[reverse]
                                                            ['caption']
                                                        : '',
                                            image: messages[reverse]
                                                        ['message_type'] ==
                                                    'attachment'
                                                ? Image.network(
                                                    imgBaseUrl +
                                                        messages[reverse]
                                                            ['message'],
                                                    height: 184,
                                                    width: 154,
                                                  )
                                                : messages[reverse]
                                                            ['message_type'] ==
                                                        'other'
                                                    ? Image.network(
                                                        imgBaseUrl +
                                                            messages[reverse]
                                                                ['message'],
                                                        height: 184,
                                                        width: 154,
                                                      )
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
                                              ? Image.network(
                                                  imgBaseUrl +
                                                      messages[reverse]
                                                          ['message'],
                                                  height: 184,
                                                  width: 154,
                                                )
                                              : messages[reverse]
                                                          ['message_type'] ==
                                                      'other'
                                                  ? Image.network(
                                                      imgBaseUrl +
                                                          messages[reverse]
                                                              ['message'],
                                                      height: 184,
                                                      width: 154,
                                                    )
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
                      isEmojiShowing: _emojiShowing,
                      focusNode: _focusNode,
                      onEmojiButtonTap: () {
                        setState(() {
                          _emojiShowing = !_emojiShowing;

                          if (!_emojiShowing) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              _focusNode.requestFocus();
                            });
                          } else {
                            _focusNode.unfocus();
                          }
                        });
                      },
                      onTap: () {
                        if (_emojiShowing) {
                          setState(() {
                            _emojiShowing = false;
                          });
                        }
                      },
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

                          // if (selectedImageInBase64 != '') {
                          //   setState(() {
                          //     userProfile = '';
                          //   });
                          // }
                        }
                        if (result == 'gallery') {
                          images = await getImage(from: 'gallery');
                          if (images.isNotEmpty) {
                            setState(() {
                              selectedImageInBase64 =
                                  images['image']['imageInBase64'];
                            });
                          }

                          // if (selectedImageInBase64 != '') {
                          // setState(() {
                          //   userProfile = '';
                          // });
                          // }
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
                    SizedBox(
                      height: 12,
                    ),
                    _emojiShowing != false
                        ? Container(
                            // margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Offstage(
                              offstage: !_emojiShowing,
                              child: EmojiPicker(
                                textEditingController: msgTextFieldController,
                                scrollController: _scrollController,
                                config: Config(
                                  height: 218,
                                  checkPlatformCompatibility: true,
                                  emojiTextStyle: _textStyle,
                                  emojiViewConfig: const EmojiViewConfig(
                                    backgroundColor: Colors.white,
                                  ),
                                  swapCategoryAndBottomBar: true,
                                  skinToneConfig: const SkinToneConfig(),
                                  categoryViewConfig: CategoryViewConfig(
                                    backgroundColor: Colors.white,
                                    dividerColor: Colors.white,
                                    indicatorColor: accentColor,
                                    iconColorSelected: Colors.black,
                                    iconColor: secondaryColor,
                                    customCategoryView: (
                                      config,
                                      state,
                                      tabController,
                                      pageController,
                                    ) {
                                      return WhatsAppCategoryView(
                                        config,
                                        state,
                                        tabController,
                                        pageController,
                                      );
                                    },
                                    categoryIcons: const CategoryIcons(
                                      recentIcon: Icons.access_time_outlined,
                                      smileyIcon: Icons.emoji_emotions_outlined,
                                      animalIcon: Icons.cruelty_free_outlined,
                                      foodIcon: Icons.coffee_outlined,
                                      activityIcon:
                                          Icons.sports_soccer_outlined,
                                      travelIcon:
                                          Icons.directions_car_filled_outlined,
                                      objectIcon: Icons.lightbulb_outline,
                                      symbolIcon: Icons.emoji_symbols_outlined,
                                      flagIcon: Icons.flag_outlined,
                                    ),
                                  ),
                                  bottomActionBarConfig:
                                      const BottomActionBarConfig(
                                    backgroundColor: Colors.white,
                                    buttonColor: Colors.white,
                                    buttonIconColor: secondaryColor,
                                  ),
                                  searchViewConfig: SearchViewConfig(
                                    backgroundColor: Colors.white,
                                    customSearchView: (
                                      config,
                                      state,
                                      showEmojiView,
                                    ) {
                                      return WhatsAppSearchView(
                                        config,
                                        state,
                                        showEmojiView,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
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

/// Customized Whatsapp category view
class WhatsAppCategoryView extends CategoryView {
  const WhatsAppCategoryView(
    super.config,
    super.state,
    super.tabController,
    super.pageController, {
    super.key,
  });

  @override
  WhatsAppCategoryViewState createState() => WhatsAppCategoryViewState();
}

class WhatsAppCategoryViewState extends State<WhatsAppCategoryView>
    with SkinToneOverlayStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.config.categoryViewConfig.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: WhatsAppTabBar(
              widget.config,
              widget.tabController,
              widget.pageController,
              widget.state.categoryEmoji,
              closeSkinToneOverlay,
            ),
          ),
          _buildBackspaceButton(),
        ],
      ),
    );
  }

  Widget _buildBackspaceButton() {
    if (widget.config.categoryViewConfig.showBackspaceButton) {
      return BackspaceButton(
        widget.config,
        widget.state.onBackspacePressed,
        widget.state.onBackspaceLongPressed,
        widget.config.categoryViewConfig.backspaceColor,
      );
    }
    return const SizedBox.shrink();
  }
}

class WhatsAppTabBar extends StatelessWidget {
  const WhatsAppTabBar(
    this.config,
    this.tabController,
    this.pageController,
    this.categoryEmojis,
    this.closeSkinToneOverlay, {
    super.key,
  });

  final Config config;

  final TabController tabController;

  final PageController pageController;

  final List<CategoryEmoji> categoryEmojis;

  final VoidCallback closeSkinToneOverlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: config.categoryViewConfig.tabBarHeight,
      child: TabBar(
        labelColor: config.categoryViewConfig.iconColorSelected,
        indicatorColor: config.categoryViewConfig.indicatorColor,
        unselectedLabelColor: config.categoryViewConfig.iconColor,
        dividerColor: config.categoryViewConfig.dividerColor,
        controller: tabController,
        labelPadding: const EdgeInsets.only(top: 1.0),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
        ),
        onTap: (index) {
          closeSkinToneOverlay();
          pageController.jumpToPage(index);
        },
        tabs: categoryEmojis
            .asMap()
            .entries
            .map<Widget>(
                (item) => _buildCategory(item.key, item.value.category))
            .toList(),
      ),
    );
  }

  Widget _buildCategory(int index, Category category) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          getIconForCategory(
            config.categoryViewConfig.categoryIcons,
            category,
          ),
          size: 20,
        ),
      ),
    );
  }
}

/// Custom Whatsapp Search view implementation
class WhatsAppSearchView extends SearchView {
  const WhatsAppSearchView(super.config, super.state, super.showEmojiView,
      {super.key});

  @override
  WhatsAppSearchViewState createState() => WhatsAppSearchViewState();
}

class WhatsAppSearchViewState extends SearchViewState {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final emojiSize =
          widget.config.emojiViewConfig.getEmojiSize(constraints.maxWidth);
      final emojiBoxSize =
          widget.config.emojiViewConfig.getEmojiBoxSize(constraints.maxWidth);
      return Container(
        color: widget.config.searchViewConfig.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: emojiBoxSize + 8.0,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                scrollDirection: Axis.horizontal,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return buildEmoji(
                    results[index],
                    emojiSize,
                    emojiBoxSize,
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: widget.showEmojiView,
                  color: widget.config.searchViewConfig.buttonColor,
                  icon: Icon(
                    Icons.arrow_back,
                    color: widget.config.searchViewConfig.buttonIconColor,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onTextInputChanged,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.config.searchViewConfig.hintText,
                      hintStyle: const TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
