import 'package:flutter/material.dart';
import 'package:Uzaar/utils/colors.dart';

class ReusableText extends StatelessWidget {
  final String text;
  const ReusableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBodyTextStyle,
    );
  }
}
