import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellpad/utils/Colors.dart';

class FeaturedServicesWidget extends StatefulWidget {
  final String image;
  final String productCategory;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  const FeaturedServicesWidget(
      {super.key,
      required this.image,
      required this.productCategory,
      required this.productDescription,
      required this.productLocation,
      required this.productPrice});

  @override
  State<FeaturedServicesWidget> createState() => _FeaturedServicesWidgetState();
}

class _FeaturedServicesWidgetState extends State<FeaturedServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 160.w,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 125.h,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.asset(
                    widget.image,
                    width: 160.w,
                    height: 125.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: GestureDetector(
                    onTap: null,
                    child: SvgPicture.asset(
                      'assets/verify-check.svg',
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  bottom: 5,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.h),
                            width: 70.w,
                            height: 27.h,
                            decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                widget.productCategory,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Text(
                                  '4.5',
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, right: 6.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ).copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/address-icon.svg',
                          width: 14.w,
                          height: 14.h,
                          fit: BoxFit.scaleDown,
                        ),
                        // SizedBox(
                        //   width: 2.w,
                        // ),
                        SizedBox(
                          // width: 110.w,
                          child: Text(
                            widget.productLocation,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'From',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/price-tag.svg',
                      width: 14.w,
                      height: 14.h,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '\$${widget.productPrice}',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
