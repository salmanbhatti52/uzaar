import 'package:flutter/material.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';

class NavigateBack extends StatelessWidget {
  final BuildContext buildContext;
  NavigateBack({required this.buildContext});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(buildContext),
      child: SvgIcon(
        imageName: 'assets/back-arrow-button.svg',
      ),
    );
  }
}
