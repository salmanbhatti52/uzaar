import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';

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
final durationTextStyle = GoogleFonts.outfit(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  color: grey,
);

class SalesOrdersProductsListTile extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productLocation;
  final String productPrice;
  final String date;
  final String? offeredPrice;
  final dynamic Function(dynamic)? onSelected;

  final String? initialSelection;

  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  // final void Function()? onTapPayNow;
  // final bool? allowPay;
  // final String? offerStatus;

  SalesOrdersProductsListTile(
      {required this.productImage,
      required this.productName,
      required this.productLocation,
      required this.productPrice,
      required this.date,
      this.offeredPrice,
      // this.onTapPayNow,
      // this.allowPay,
      // this.offerStatus,
      this.initialSelection,
      this.onSelected,
      required this.dropdownMenuEntries});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
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
          Image.asset(productImage),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                SizedBox(
                  height: 4,
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
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          productLocation,
                          style: locationNameTextStyle,
                        )
                      ],
                    ),
                    // allowPay == true
                    //     ? GestureDetector(
                    //         onTap: onTapPayNow,
                    //         child: Text(
                    //           'Pay Now',
                    //           style: kFontTwelveSixHPB,
                    //         ))
                    //     : const SizedBox()
                  ],
                ),
                SizedBox(
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
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              productPrice,
                              style: priceTextStyle,
                            )
                          ],
                        ),
                        offeredPrice != null
                            ? SizedBox(
                                height: 4,
                              )
                            : SizedBox(),
                        offeredPrice != null
                            ? Row(
                                children: [
                                  Text(
                                    offeredPrice!,
                                    style: priceTextStyle,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'offered',
                                    style: kFontTenFiveHG,
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                    // offerStatus != null?
                    RoundedMiniDropdownMenu(
                      width: 115,
                      onSelected: onSelected,
                      initialSelection: initialSelection,
                      dropdownMenuEntries: dropdownMenuEntries,
                      fillColor: primaryBlue,
                      textStyle: kFontTwelveSixHW,
                      // hintText: 'Products',
                      leadingIconName: null,
                      colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                      // trailingIconName: 'grid_icon',
                    )
                    // : SizedBox()
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
