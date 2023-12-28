import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';

import 'icon_text_combo.dart';
import 'mini_dropdown_menu.dart';

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
final houseTypeTextStyle = GoogleFonts.outfit(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: primaryBlue,
);
final durationTextStyle = GoogleFonts.outfit(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  color: grey,
);

class SalesOrdersHousingsListTile extends StatelessWidget {
  final String houseImage;
  final String houseName;
  final String houseLocation;
  final String housePrice;
  final String houseType;
  final String houseArea;
  final String noOfBeds;
  final String noOfBaths;
  final String date;
  final String? offeredPrice;
  final dynamic Function(dynamic)? onSelected;

  final String? initialSelection;

  final List<DropdownMenuEntry<String>> dropdownMenuEntries;

  const SalesOrdersHousingsListTile(
      {super.key, required this.houseImage,
      required this.houseName,
      required this.houseLocation,
      required this.housePrice,
      required this.houseArea,
      required this.houseType,
      required this.noOfBaths,
      required this.noOfBeds,
      required this.date,
      this.offeredPrice,
      this.initialSelection,
      this.onSelected,
      required this.dropdownMenuEntries});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(houseImage),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.35,
                      child: Text(
                        houseName,
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
                Text(
                  houseType,
                  style: houseTypeTextStyle,
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
                      houseLocation,
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
                      housePrice,
                      style: priceTextStyle,
                    )
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
                        IconTextReusable(
                          imageName: 'area_icon',
                          text: '$houseArea sq.mt',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconTextReusable(
                              imageName: 'bath_icon',
                              text: noOfBaths,
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            IconTextReusable(
                              imageName: 'bed_icon',
                              text: noOfBeds,
                            ),
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
                    RoundedMiniDropdownMenu(
                      enabled: true,
                      width: 115,
                      onSelected: onSelected,
                      initialSelection: initialSelection,
                      dropdownMenuEntries: dropdownMenuEntries,
                      fillColor: primaryBlue,
                      textStyle: kFontTwelveSixHW,
                      // hintText: 'Products',
                      leadingIconName: null,
                      colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
                      // trailingIconName: 'grid_icon',
                    )
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
