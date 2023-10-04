import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class SvgIcon extends StatelessWidget {
  String imageName;
  ColorFilter? colorFilter;
  SvgIcon({required this.imageName, this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      colorFilter: colorFilter,
      fit: BoxFit.scaleDown,
    );
  }
}
