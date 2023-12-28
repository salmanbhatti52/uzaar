import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HeadingAndDetail extends StatelessWidget {
  const HeadingAndDetail({super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: kFontSixteenSixHB,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: kSimpleTextStyle,
        )
      ],
    );
  }
}
