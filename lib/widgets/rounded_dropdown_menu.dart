import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';

import '../utils/colors.dart';

final kDropDownMenuInputDecoration = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 46),
  contentPadding: EdgeInsets.only(left: 14),
  border: kRoundedWhiteBorderStyle,
  enabledBorder: kRoundedWhiteBorderStyle,
  focusedBorder: kRoundedActiveBorderStyle,
  fillColor: white,
  labelStyle: kTextFieldInputStyle,
  filled: true,
  hintStyle: kTextFieldHintStyle,
);
final kDropDownMenuStyle = MenuStyle(
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
      this.initialSelection,
      this.width});
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  final String leadingIconName;
  final String hintText;
  final double? width;
  final Object? initialSelection;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      child: DropdownMenu(
        menuHeight: 150,
        textStyle: kTextFieldInputStyle,
        hintText: hintText,
        trailingIcon: SvgIcon(imageName: 'assets/dropdown_icon.svg'),
        leadingIcon: SvgIcon(imageName: 'assets/$leadingIconName.svg'),
        inputDecorationTheme: kDropDownMenuInputDecoration,
        menuStyle: kDropDownMenuStyle,
        width: width,
        initialSelection: initialSelection,
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}
