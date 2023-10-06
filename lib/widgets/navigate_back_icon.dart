import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigateBack extends StatelessWidget {
  final BuildContext buildContext;
  NavigateBack({required this.buildContext});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(buildContext),
      child: SvgPicture.asset(
        'assets/back-arrow-button.svg',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
