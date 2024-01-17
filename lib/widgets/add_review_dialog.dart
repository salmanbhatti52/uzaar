import 'package:uzaar/utils/Colors.dart';
import 'package:flutter/material.dart';

class AddReviewDialog extends StatelessWidget {
  const AddReviewDialog(
      {super.key,
      required this.content,
      required this.title,
      required this.textField,
      this.itemsList});
  final Widget title;
  final Widget content;
  final Widget textField;

  final List<Widget>? itemsList;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.only(top: 25, left: 6, right: 6, bottom: 15),
      titlePadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      contentPadding: const EdgeInsets.only(top: 0, left: 6, right: 6),
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      titleTextStyle: kBodyPrimaryBoldTextStyle,
      elevation: 3,
      contentTextStyle: kSimpleTextStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: title,
      content: content,
      actions: [
        // itemsList != null
        //     ? Container(
        //         margin: EdgeInsets.only(bottom: 35),
        //         child: Column(
        //           children: itemsList ?? [],
        //         ),
        //       )
        //     : Container(
        //         height: 15,
        //       ),
        SizedBox(
          height: 10,
          width: MediaQuery.sizeOf(context).width,
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 14.0, left: 12, right: 12),
            child: textField)
      ],
    );
  }
}
