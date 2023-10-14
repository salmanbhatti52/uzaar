import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';

import '../utils/Colors.dart';

final kdropdownMenuInputDecoration = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 50.h),
  contentPadding: EdgeInsets.only(left: 14),
  border: kRoundedWhiteBorderStyle,
  enabledBorder: kRoundedWhiteBorderStyle,
  focusedBorder: kRoundedActiveBorderStyle,
  fillColor: white,
  labelStyle: kTextFieldInputStyle,
  filled: true,
  hintStyle: kTextFieldHintStyle,
);
final kdropdownMenuStyle = MenuStyle(
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15))));

class RoundedDropdownMenu extends StatelessWidget {
  const RoundedDropdownMenu(
      {super.key,
      required this.onSelected,
      required this.dropdownMenuEntries,
      required this.hintText,
      required this.leadingIconName,
      this.width});
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  final String leadingIconName;
  final String hintText;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      child: DropdownMenu(
        textStyle: kTextFieldInputStyle,
        hintText: hintText,
        trailingIcon: SvgIcon(imageName: 'assets/dropdown_icon.svg'),
        leadingIcon: SvgIcon(imageName: 'assets/$leadingIconName.svg'),
        inputDecorationTheme: kdropdownMenuInputDecoration,
        menuStyle: kdropdownMenuStyle,
        width: width ?? MediaQuery.sizeOf(context).width * 0.88,
        // initialSelection: null,
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}
