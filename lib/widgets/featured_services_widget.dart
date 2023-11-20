import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';

final kCardTagTextStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  color: white,
);
final kNewTagTextStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);

final kCardHeadingTextStyle = GoogleFonts.outfit(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: black,
);

final kLocationTexStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: grey,
);

final kPriceTextStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);

final kFromTagTextStyle = GoogleFonts.outfit(
  fontSize: 8,
  fontWeight: FontWeight.w400,
  color: grey,
);

class FeaturedServicesWidget extends StatelessWidget {
  final String image;
  final String serviceCategory;
  final String serviceName;
  final String serviceLocation;
  final String servicePrice;
  final void Function()? onOptionTap;
  final void Function()? onImageTap;
  const FeaturedServicesWidget({
    super.key,
    required this.image,
    required this.serviceCategory,
    required this.serviceName,
    required this.serviceLocation,
    required this.servicePrice,
    required this.onOptionTap,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 2, bottom: 2, left: 1),
      width: 154,
      decoration: kCardBoxDecoration,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: GestureDetector(
                  onTap: onImageTap,
                  child: Image.network(
                    width: 154,
                    height: 124,
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 5,
                child: SvgPicture.asset(
                  'assets/verify-check.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              Positioned(
                right: 3,
                top: 5,
                child: GestureDetector(
                  onTap: onOptionTap,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 6,
                bottom: 9,
                child: Container(
                  // padding: EdgeInsets.all(6.h),
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      serviceCategory,
                      style: kCardTagTextStyle,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '4.5',
                      style: kCardTagTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    serviceName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: kCardHeadingTextStyle,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        SvgPicture.asset(
                          'assets/address-icon.svg',
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            serviceLocation,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: kLocationTexStyle,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: kFromTagTextStyle,
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/price-tag.svg',
                              width: 14,
                              height: 14,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                '\$$servicePrice',
                                style: kPriceTextStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                // SizedBox(
                //   height: 4.h,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
