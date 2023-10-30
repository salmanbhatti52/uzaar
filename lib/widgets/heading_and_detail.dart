import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HeadingAndDetail extends StatelessWidget {
  const HeadingAndDetail({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: kFontSixteenSixHB,
        ),
        SizedBox(
          height: 14,
        ),
        Text(
          description,
          style: kSimpleTextStyle,
        )
      ],
    );
  }
}
