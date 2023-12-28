import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField(
      {super.key,
      required this.msgTextFieldController,
      this.onTap,
      this.onSaved,
      required this.sendButtonTap});

  final TextEditingController msgTextFieldController;
  final void Function()? sendButtonTap;
  final void Function()? onTap;
  final void Function(String?)? onSaved;

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
        // width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(left: 20),

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
                onTap: onTap,
                onSaved: onSaved,
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
            SvgPicture.asset('assets/attachment_icon.svg'),
            const SizedBox(
              width: 6,
            ),
            SvgPicture.asset('assets/emoji_icon.svg'),
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
