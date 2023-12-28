import 'package:Uzaar/utils/Colors.dart';
import 'package:flutter/material.dart';

class AlertDialogReusable extends StatelessWidget {
  const AlertDialogReusable(
      {super.key,
      required this.description,
      required this.title,
      required this.button,
      this.itemsList});
  final String title;
  final String description;
  final Widget button;
  final List<Widget>? itemsList;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
      contentPadding: const EdgeInsets.only(top: 30, left: 36, right: 36),
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      titleTextStyle: kBodyPrimaryBoldTextStyle,
      elevation: 3,
      contentTextStyle: kSimpleTextStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
      ),
      actions: [
        itemsList != null
            ? Container(
                margin: const EdgeInsets.only(bottom: 35),
                child: Column(
                  children: itemsList ?? [],
                ),
              )
            : Container(
                height: 15,
              ),
        Padding(
            padding: const EdgeInsets.only(bottom: 14.0, left: 12, right: 12),
            child: button)
      ],
    );
  }
}
