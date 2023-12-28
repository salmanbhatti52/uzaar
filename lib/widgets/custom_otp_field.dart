import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class CustomOTPField extends StatefulWidget {
  final int length;
  final Function(String) onSubmitted;

  const CustomOTPField({super.key, required this.length, required this.onSubmitted});

  @override
  _CustomOTPFieldState createState() => _CustomOTPFieldState();
}

class _CustomOTPFieldState extends State<CustomOTPField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _textControllers =
        List.generate(widget.length, (index) => TextEditingController());

    for (int i = 0; i < widget.length; i++) {
      _textControllers[i].addListener(() {
        if (_textControllers[i].text.length == 1) {
          if (i + 1 < widget.length) {
            _focusNodes[i + 1].requestFocus();
          } else {
            // Last character entered
            String otpCode = _textControllers.fold<String>(
                "", (prev, controller) => prev + controller.text);
            widget.onSubmitted(otpCode);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Container(
          width: 50,
          margin: const EdgeInsets.only(left: 7, right: 7),
          decoration: kOtpBoxDecoration,
          child: TextField(
            controller: _textControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            // decoration: InputDecoration(
            //   border: OutlineInputBorder(),
            //   counterText: "",
            // ),
            cursorColor: primaryBlue,
            decoration: kOptInputDecoration,

            style: kTextFieldInputStyle,
            maxLength: 1,
            onChanged: (value) {
              if (value.isEmpty) {
                // Clear the field if the user deletes the input
                if (index - 1 >= 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
