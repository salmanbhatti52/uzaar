import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String imageName;
  final ColorFilter? colorFilter;
  final double? width;
  final double? height;

  SvgIcon({required this.imageName, this.colorFilter, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      colorFilter: colorFilter,
      fit: BoxFit.scaleDown,
      width: width,
      height: height,
    );
  }
}
