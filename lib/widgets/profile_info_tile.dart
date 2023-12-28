import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Colors.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile(
      {super.key,
      required this.imageName,
      required this.title,
      required this.description});
  final String imageName;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: f5f5f5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/$imageName'),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kSimpleTextStyle,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                description,
                style: kFontSixteenSixHB,
              )
            ],
          )
        ],
      ),
    );
  }
}
