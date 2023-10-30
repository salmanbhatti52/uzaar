import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

final kDropDownBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: white,
    width: 1,
  ),
);
final TextStyle kDropDownHintStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: grey,
);

final TextStyle dropDownTextStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: black,
);
final kDropDownMenuInputDecoration = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 30),
  contentPadding: EdgeInsets.only(
    left: 15,
  ),
  border: kDropDownBorderStyle,
  enabledBorder: kDropDownBorderStyle,
  focusedBorder: kDropDownBorderStyle,
  fillColor: white,
  labelStyle: dropDownTextStyle,
  filled: true,
  hintStyle: kDropDownHintStyle,
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

class RoundedMiniDropdownMenu extends StatelessWidget {
  const RoundedMiniDropdownMenu(
      {super.key,
      required this.onSelected,
      required this.dropdownMenuEntries,
      this.hintText,
      this.leadingIconName,
      this.width,
      this.initialSelection,
      this.trailingIconName = 'drop-down-button'});
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  final String? leadingIconName;
  final String? trailingIconName;
  final String? hintText;
  final double? width;
  final String? initialSelection;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      child: DropdownMenu(
        textStyle: dropDownTextStyle,
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
        initialSelection: initialSelection,
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}
