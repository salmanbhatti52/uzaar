import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzaar/utils/colors.dart';

import 'icon_text_combo.dart';

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

class FeaturedHousingWidget extends StatelessWidget {
  final String image;
  final String housingCategory;
  final String housingName;
  final String housingLocation;
  final String housingPrice;
  final String area;
  final String furnishedStatus;
  final String bedrooms;
  final String bathrooms;
  final void Function()? onOptionTap;
  final void Function()? onImageTap;
  final String? sellerProfileVerified;
  const FeaturedHousingWidget(
      {super.key,
      required this.image,
      required this.housingCategory,
      required this.housingName,
      required this.housingLocation,
      required this.housingPrice,
      required this.area,
      required this.bedrooms,
      required this.bathrooms,
      required this.onOptionTap,
      required this.onImageTap,
      required this.furnishedStatus,
      required this.sellerProfileVerified});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 2, bottom: 2, left: 1),
      width: 154,
      decoration: kCardBoxDecoration,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
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
              sellerProfileVerified == 'Yes'
                  ? Positioned(
                      left: 6,
                      top: 5,
                      child: SvgPicture.asset(
                        'assets/verify-check.svg',
                        width: 20,
                        height: 20,
                      ),
                    )
                  : const Positioned(child: SizedBox()),
              Positioned(
                right: 3,
                top: 5,
                child: GestureDetector(
                  onTap: onOptionTap,
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 6,
                bottom: 9,
                child: Container(
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      housingCategory,
                      style: kCardTagTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    housingName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: kCardHeadingTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/address-icon.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            housingLocation,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: kLocationTexStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/price-tag.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                            constraints: const BoxConstraints(maxWidth: 50),
                            child: Text(
                              '\$$housingPrice',
                              style: kPriceTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  furnishedStatus,
                  style: kFontEightFiveHPB,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextReusable(
                      mainAxisAlignment: MainAxisAlignment.start,
                      imageName: 'area_icon',
                      text: '$area sq.ft',
                    ),
                    IconTextReusable(
                      mainAxisAlignment: MainAxisAlignment.start,
                      imageName: 'bath_icon',
                      text: bathrooms,
                    ),
                    IconTextReusable(
                      mainAxisAlignment: MainAxisAlignment.start,
                      imageName: 'bed_icon',
                      text: bedrooms,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
