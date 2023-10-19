import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String imageName;
  final ColorFilter? colorFilter;

  const SvgIcon({super.key, required this.imageName, this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      colorFilter: colorFilter,
      fit: BoxFit.scaleDown,
    );
  }
}
