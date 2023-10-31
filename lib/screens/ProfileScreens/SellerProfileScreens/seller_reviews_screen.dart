import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/colors.dart';

import '../../../widgets/review_tile_widget.dart';

class SellerReviewsScreen extends StatefulWidget {
  const SellerReviewsScreen({super.key});

  @override
  State<SellerReviewsScreen> createState() => _SellerReviewsScreenState();
}

class _SellerReviewsScreenState extends State<SellerReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: primaryBlue,
        child: RefreshIndicator(
          onRefresh: () async {},
          color: primaryBlue,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 15),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 6,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ReviewListTile(
                imageName: 'assets/chat_image.png',
                title: 'John Doe',
                detail: 'Lorem ipsum dolor sit amet consectetur.',
                date: '08/08/2023',
                showProductImage: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
