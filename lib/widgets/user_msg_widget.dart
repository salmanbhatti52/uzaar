import 'package:flutter/material.dart';

import '../services/restService.dart';
import '../utils/Colors.dart';

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
          constraints: const BoxConstraints(minWidth: 100,maxWidth: 180),
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.zero,
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14))),
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
                style: kFontFourteenFourHW,
              ),
              const SizedBox(
                height: 4,
              ),
              // image == null
              //     ?
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Text(
                  date,
                  style: kFontTwelveThreeHW,
                ),
              )
                  // : const SizedBox()
            ],
          ),
        ),
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
                  : null),
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
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 50, maxWidth: 150),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
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