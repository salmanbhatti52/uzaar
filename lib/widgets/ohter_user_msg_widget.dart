import 'package:flutter/material.dart';

import '../services/restService.dart';
import '../utils/Colors.dart';

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
          backgroundColor: const Color(0xFFD9D9D9),
          maxRadius: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: networkImagePath.isNotEmpty
                ? Image.network(
              imgBaseUrl + networkImagePath,
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            )
                : null,
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 180),
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
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
                margin: image != null ? const EdgeInsets.only(bottom: 4) : null,
                child: image,
              ),
              Text(
                msgText,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: kTextFieldInputStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              // image == null
              //     ?
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  date,
                  style: kFontTwelveFourHG,
                  textAlign: TextAlign.left,
                ),
              )
                  // : const SizedBox()
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
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 50, maxWidth: 150),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.zero)),
        )
      ],
    );
  }
}