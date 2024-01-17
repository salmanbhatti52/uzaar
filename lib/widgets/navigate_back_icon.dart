import 'package:flutter/material.dart';
import 'package:uzaar/widgets/suffix_svg_icon.dart';

class NavigateBack extends StatelessWidget {
  final BuildContext buildContext;
  final ColorFilter? colorFilter;
  const NavigateBack({super.key, required this.buildContext, this.colorFilter});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(buildContext),
      child: SvgIcon(
        imageName: 'assets/back-arrow-button.svg',
        colorFilter: colorFilter,
      ),
    );
  }
}
