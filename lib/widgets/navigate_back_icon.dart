import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigateBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SvgPicture.asset(
        'assets/back-arrow-button.svg',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
