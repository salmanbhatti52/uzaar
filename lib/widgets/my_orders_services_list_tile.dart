import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';

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

class MyOrdersServicesListTile extends StatelessWidget {
  final String serviceImage;
  final String serviceName;
  final String serviceLocation;
  final String servicePrice;
  final String date;
  final String? offeredPrice;

  const MyOrdersServicesListTile(
      {super.key, required this.serviceImage,
      required this.serviceName,
      required this.serviceLocation,
      required this.servicePrice,
      required this.date,
      this.offeredPrice});

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
        children: [
          Image.asset(serviceImage),
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
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Text(
                        serviceName,
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
                  children: [
                    SvgPicture.asset(
                      'assets/address-icon.svg',
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      serviceLocation,
                      style: locationNameTextStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
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
                      servicePrice,
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
          ),
        ],
      ),
    );
  }
}
