import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Widget> getStars(int noOfStars, double? width, double? height) {
  List<Widget> stars = [];
  const space = SizedBox(width: 4);
  final star = SvgPicture.asset(
    'assets/star.svg',
    height: height,
    width: width,
  );
  stars.add(space);
  for (int i = 0; i < noOfStars; i++) {
    stars.add(star);
    stars.add(space);
  }
  return stars;
}

class StarsTile extends StatelessWidget {
  const StarsTile(
      {super.key,
      required this.noOfStars,
      this.height,
      this.width,
      required this.alignment});
  final int noOfStars;
  final double? height;
  final double? width;
  final MainAxisAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: getStars(noOfStars, width, height),
    );
  }
}
