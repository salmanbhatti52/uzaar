import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'featured_housing_widget.dart';

class CarouselBuilder extends StatelessWidget {
  const CarouselBuilder(
      {super.key, required this.image, required this.categoryName});
  final String image;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Stack(
        children: [
          Image.network(
            image,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 21,
            bottom: 21,
            child: Container(
              width: 70,
              height: 24,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: kCardTagTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
      options: CarouselOptions(
          height: 200,

          // aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          clipBehavior: Clip.hardEdge),
    );
  }
}
