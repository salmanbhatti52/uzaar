import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzaar/utils/colors.dart';

import '../services/restService.dart';

final productNameTextStyle = GoogleFonts.outfit(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: black,
);
final locationNameTextStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: grey,
);

final priceTextStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);
final durationTextStyle = GoogleFonts.outfit(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  color: grey,
);

class MyOrdersProductsListTile extends StatelessWidget {
  final String productImage;
  final String productName;
  // final String productLocation;
  final String productPrice;
  final String date;
  final String? offeredPrice;
  final Future<String> Function(String)? onTapArrange;

  final bool? allowPay;
  final String? offerStatus;
  final String? productCondition;

  const MyOrdersProductsListTile(
      {super.key,
      required this.productImage,
      required this.productName,
      // required this.productLocation,
      required this.productPrice,
      required this.date,
      this.offeredPrice,
      this.onTapArrange,
      this.allowPay,
      this.offerStatus,
      this.productCondition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgBaseUrl + productImage,
              height: 60,
              width: 74,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.38,
                      child: Text(
                        productName,
                        style: productNameTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      style: durationTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        productCondition != null
                            ? SizedBox(
                                width: 60,
                                child: Text(
                                  productCondition ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                  style: kColoredTextStyle,
                                ),
                              )
                            : const SizedBox()
                        // SvgPicture.asset(
                        //   'assets/address-icon.svg',
                        //   width: 14,
                        //   height: 14,
                        // ),
                        // SizedBox(
                        //   width: 4,
                        // ),
                        // Text(
                        //   productLocation,
                        //   style: locationNameTextStyle,
                        // )
                      ],
                    ),
                    allowPay == true
                        ? Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    onTapArrange!('meetup');
                                  },
                                  child: Text(
                                    'Meet-up',
                                    style: kFontFourteenSixHPB,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    onTapArrange!('shipping');
                                  },
                                  child: Text(
                                    'Ship',
                                    style: kFontFourteenSixHPB,
                                  )),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/price-tag.svg',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              productPrice,
                              style: priceTextStyle,
                            )
                          ],
                        ),
                        offeredPrice != null
                            ? const SizedBox(
                                height: 4,
                              )
                            : const SizedBox(),
                        offeredPrice != null
                            ? Row(
                                children: [
                                  Text(
                                    offeredPrice!,
                                    style: priceTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'offered',
                                    style: kFontTenFiveHG,
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                    offerStatus != null
                        ? Container(
                            width: 80,
                            height: 27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: offerStatus == 'Accepted'
                                  ? lightGreen
                                  : offerStatus == 'Rejected'
                                      ? red
                                      : offerStatus == 'Pending'
                                          ? yellow
                                          : black,
                            ),
                            child: Center(
                              child: Text(
                                offerStatus!,
                                style: kFontTwelveSixHW,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyOrdersProductsListTileDummy extends StatelessWidget {
  const MyOrdersProductsListTileDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.3),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4.0,
          ),
        ],
      ),
    );
  }
}
