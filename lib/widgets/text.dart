import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/utils/Colors.dart';

class ReusableText extends StatelessWidget {
  final String text;
  ReusableText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    );
  }
}
