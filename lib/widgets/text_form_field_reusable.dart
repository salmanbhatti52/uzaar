import 'package:flutter/material.dart';

import 'package:Uzaar/utils/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  // final TextStyle enterTextStyle;
  // final Color cursorColor;
  final String hintText;
  final VoidCallback? onTap;
  // final InputBorder border;
  // final TextStyle hintStyle;
  // final InputBorder focusedBorder;
  //
  // final InputBorder enableBorder;
  final Widget prefixIcon;
  final String? autofillHints;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onSaved;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool? readOnly;
  final void Function(String)? onSubmitted;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.textInputType,
    // required this.enterTextStyle,
    this.readOnly,
    // required this.cursorColor,
    required this.hintText,
    // required this.border,
    // required this.hintStyle,
    // required this.focusedBorder,
    this.onSaved,
    this.validator,
    this.onTap,
    this.autofillHints,
    this.onSubmitted,
    required this.obscureText,
    this.suffixIcon,
    // required this.enableBorder,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      child: TextFormField(
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
        onTap: onTap,
        readOnly: readOnly ?? false,
        validator: validator,
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(
        //     widget.length,
        //   ),
        // ],
        keyboardType: textInputType,
        controller: controller,
        style: kTextFieldInputStyle,
        cursorColor: primaryBlue,
        obscureText: obscureText ?? false,
        autofillHints: [autofillHints ?? ''],
        decoration: InputDecoration(
          constraints: BoxConstraints(minHeight: 46),
          filled: true,
          fillColor: white,
          suffixIcon: suffixIcon,
          // contentPadding: contentPadding,
          border: kRoundedWhiteBorderStyle,
          enabledBorder: kRoundedWhiteBorderStyle,

          hintText: hintText,
          hintStyle: kTextFieldHintStyle,
          focusedBorder: kRoundedActiveBorderStyle,
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(40),
          //     borderSide: BorderSide(
          //       width: 1.5,
          //       color: Color.fromRGBO(0, 0, 0, 0.14),
          //     )),
          prefixIcon: prefixIcon,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
