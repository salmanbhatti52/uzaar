import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

final kDropDownActiveBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: const BorderSide(
    color: primaryBlue,
    width: 1,
  ),
);
final TextStyle kDropDownTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);
final kDropDownMenuInputDecoration = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 36),
  contentPadding: EdgeInsets.only(
    left: 15,
  ),
  border: kDropDownActiveBorderStyle,
  enabledBorder: kDropDownActiveBorderStyle,
  focusedBorder: kDropDownActiveBorderStyle,
  fillColor: white,
  labelStyle: kTextFieldInputStyle,
  filled: true,
  hintStyle: kDropDownTextStyle,
);
final kDropDownMenuStyle = MenuStyle(
    maximumSize: MaterialStatePropertyAll(Size.fromHeight(200)),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15))));

class RoundedSmallDropdownMenu extends StatelessWidget {
  const RoundedSmallDropdownMenu(
      {super.key,
      required this.onSelected,
      required this.dropdownMenuEntries,
      required this.hintText,
      this.leadingIconName,
      this.width,
      this.trailingIconName = 'drop-down-button'});
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  final String? leadingIconName;
  final String? trailingIconName;
  final String hintText;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textStyle: kDropDownTextStyle,
      hintText: hintText,
      // selectedTrailingIcon: SvgIcon(imageName: 'assets/cat-selected.svg'),
      trailingIcon: SvgIcon(
        imageName: 'assets/$trailingIconName.svg',
      ),

      leadingIcon: leadingIconName == null
          ? null
          : SvgIcon(imageName: 'assets/$leadingIconName.svg'),
      inputDecorationTheme: kDropDownMenuInputDecoration,
      menuStyle: kDropDownMenuStyle,
      width: width ?? MediaQuery.sizeOf(context).width * 0.88,
      // initialSelection: null,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
