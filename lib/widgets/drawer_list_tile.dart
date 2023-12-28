import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class DrawerListTile extends StatelessWidget {
  final void Function()? onTap;
  final String tileImageName;
  final String tileTitle;

  const DrawerListTile(
      {super.key,
      required this.onTap,
      required this.tileImageName,
      required this.tileTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      style: ListTileStyle.drawer,
      leading: SvgPicture.asset(
        'assets/$tileImageName',
        colorFilter: const ColorFilter.mode(primaryBlue, BlendMode.srcIn),
      ),
      title: Text(
        tileTitle,
        style: kBodyTextStyle,
      ),
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
