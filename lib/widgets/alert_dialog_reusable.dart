import 'package:Uzaar/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertDialogReusable extends StatelessWidget {
  AlertDialogReusable(
      {required this.description,
      required this.title,
      required this.button,
      this.itemsList});
  final String title;
  final String description;
  final Widget button;
  List<Widget>? itemsList;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        // Column(
        //   children: itemsList ?? [],
        // ),
        Column(
          children: itemsList ?? [],
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 14.0, left: 8, right: 8),
            child: button)
      ],
    );
  }
}
