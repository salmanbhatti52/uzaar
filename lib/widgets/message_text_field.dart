import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField(
      {super.key,
      required this.msgTextFieldController,
      this.onEmojiButtonTap,
      this.onTap,
      required this.sendButtonTap,
      required this.isEmojiShowing, this.focusNode, this.onAttachmentButtonTap});

  final TextEditingController msgTextFieldController;
  final void Function()? sendButtonTap;
  final void Function()? onEmojiButtonTap;
  final void Function()? onAttachmentButtonTap;
  final bool isEmojiShowing;
  final FocusNode? focusNode;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.only(left: 20, top: 7, bottom: 7, right: 10),
        constraints: const BoxConstraints(minHeight: 46, maxHeight: 120),
        // height: 46,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: msgTextFieldController,
                style: kTextFieldInputStyle.copyWith(
                  height: 1.5
                ),
                cursorColor: primaryBlue,
                onTap: onTap,
                // onSaved: onSaved,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintStyle: kTextFieldHintStyle,
                  hintText: 'Type here...',
                  border: InputBorder.none,

                  // border: kRoundedWhiteBorderStyle,
                  // enabledBorder: kRoundedWhiteBorderStyle,
                  // focusedBorder: kRoundedActiveBorderStyle,
                  contentPadding: const EdgeInsets.only(
                      // left: 15.0,
                      top: 10.0,
                      bottom: 13,
                      right: 10),
                ),
              ),
            ),
            GestureDetector(onTap: onAttachmentButtonTap,child: SvgPicture.asset('assets/attachment_icon.svg')),
            const SizedBox(
              width: 6,
            ),
            IconButton(
              onPressed: onEmojiButtonTap,
              icon: Icon(isEmojiShowing
                  ? Icons.keyboard
                  : Icons.emoji_emotions_outlined),
              color: const Color(0xFF8B98A0),
            ),
            // GestureDetector(onTap: onEmojiButtonTap,child: SvgPicture.asset('assets/emoji_icon.svg')),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: sendButtonTap,
                child: SvgPicture.asset('assets/send_icon.svg')),
          ],
        ),
      ),
    );
  }
}
