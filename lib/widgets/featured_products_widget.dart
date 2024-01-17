import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzaar/utils/colors.dart';

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

class FeaturedProductsWidget extends StatelessWidget {
  final String image;
  final String productCategory;
  final String productName;
  // final String productLocation;
  final String productPrice;
  final String productCondition;
  final void Function()? onOptionTap;
  final void Function()? onImageTap;
  const FeaturedProductsWidget(
      {super.key,
      required this.image,
      required this.productCategory,
      required this.productName,
      // required this.productLocation,
      required this.productPrice,
      required this.onOptionTap,
      required this.onImageTap,
      required this.productCondition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 2, bottom: 2, left: 1),
      width: 154,
      decoration: kCardBoxDecoration,
      child: Column(
        children: [
          Stack(
            fit: StackFit.passthrough,
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
                      productCategory,
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
                    productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: kCardHeadingTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       'assets/address-icon.svg',
                    //       width: 14,
                    //       height: 14,
                    //     ),
                    //     SizedBox(
                    //       width: 2.w,
                    //     ),
                    //     SizedBox(
                    //       width: 48,
                    //       child: Text(
                    //         productLocation,
                    //         overflow: TextOverflow.ellipsis,
                    //         maxLines: 1,
                    //         softWrap: true,
                    //         style: kLocationTexStyle,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Text(
                      productCondition,
                      style: kNewTagTextStyle,
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
                          constraints: const BoxConstraints(maxWidth: 54),
                          child: Text('\$$productPrice',
                              style: kPriceTextStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1),
                        ),
                      ],
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

class FeaturedProductsDummy extends StatelessWidget {
  const FeaturedProductsDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 2, bottom: 2, left: 1),
      width: 154,
      decoration: kCardBoxDecoration,
      child: const Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: null,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.only(left: 7.0, right: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
