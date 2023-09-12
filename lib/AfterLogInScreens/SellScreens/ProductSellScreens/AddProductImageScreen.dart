import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../constants/Buttons.dart';

class AddProductImageScreen extends StatefulWidget {
  late int pageSelected;
  AddProductImageScreen({super.key, required this.pageSelected});

  @override
  State<AddProductImageScreen> createState() => _AddProductImageScreenState();
}

class _AddProductImageScreenState extends State<AddProductImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upload or Take Picture',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            GestureDetector(
              onTap: null,
              child: SvgPicture.asset('assets/add-pic-button.svg'),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          height: 165.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryBlue),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SvgPicture.asset('assets/upload-pic.svg'),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.pageSelected = 2;
              });
            },
            child: primaryButton(context, 'Next'),
          ),
        ),
      ],
    );
  }
}
