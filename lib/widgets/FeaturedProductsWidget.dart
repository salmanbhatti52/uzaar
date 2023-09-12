import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';

class FeaturedProductsWidget extends StatefulWidget {
  final String image;
  final String productCategory;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  const FeaturedProductsWidget(
      {super.key,
      required this.image,
      required this.productCategory,
      required this.productDescription,
      required this.productLocation,
      required this.productPrice});

  @override
  State<FeaturedProductsWidget> createState() => _FeaturedProductsWidgetState();
}

class _FeaturedProductsWidgetState extends State<FeaturedProductsWidget> {
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
                  child: Container(
                    padding: EdgeInsets.all(3.h),
                    width: 70.w,
                    height: 27.h,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                    ),
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
              ],
            ),
          ),
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
            children: [
              SvgPicture.asset(
                'assets/address-icon.svg',
                width: 14.w,
                height: 14.h,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
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
          SizedBox(
            height: 7.h,
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
    );
  }
}
