import 'package:flutter/material.dart';
import 'package:sellpad/utils/Colors.dart';

class ReusableText extends StatelessWidget {
  final String text;
  ReusableText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBodyTextStyle,
    );
  }
}
