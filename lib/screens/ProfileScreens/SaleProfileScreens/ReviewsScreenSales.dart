import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';

class ReviewsScreenSales extends StatefulWidget {
  const ReviewsScreenSales({super.key});

  @override
  State<ReviewsScreenSales> createState() => _ReviewsScreenSalesState();
}

class _ReviewsScreenSalesState extends State<ReviewsScreenSales> {
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
          child: ListView.separated(
            itemCount: 6,
            shrinkWrap: false,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: grey.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryBlue),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              'assets/place-holder.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Name',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: black,
                              ),
                            ),
                            RatingBar.builder(
                              glow: true,
                              maxRating: 5,
                              tapOnlyMode: true,
                              unratedColor: grey,
                              glowColor: primaryBlue,
                              initialRating: 4,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.zero,
                              itemSize: 16,
                              itemBuilder: (BuildContext context, int index) {
                                return Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.yellow,
                                );
                              },
                              onRatingUpdate: (double value) {},
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                'The notification details The notification details The notification details The notification details .',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: grey,
                                ).copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        '4 hours ago',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: grey,
                height: 30,
              );
            },
          ),
        ),
      ),
    );
  }
}
