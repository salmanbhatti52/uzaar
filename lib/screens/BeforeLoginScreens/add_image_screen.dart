import 'package:Uzaar/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImageScreen extends StatelessWidget {
  final void Function()? fromCamera;
  final void Function()? fromGallery;
  const AddImageScreen(
      {super.key, required this.fromCamera, required this.fromGallery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photo',
            style: kTextFieldHintStyle,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: fromGallery,
            child: Text(
              'From Photos',
              style: kTextFieldInputStyle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: fromCamera,
            child: Text(
              'Take Picture',
              style: kTextFieldInputStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
