import 'package:Uzaar/widgets/popup_menu_button.dart';
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

class ProductListTile extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productCondition;
  final String productPrice;
  final void Function(dynamic)? onSelected;
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  final dynamic initialValue;

  ProductListTile({
    required this.productImage,
    required this.productName,
    required this.productCondition,
    required this.productPrice,
    required this.onSelected,
    required this.itemBuilder,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
      padding: EdgeInsets.only(left: 9, top: 9, bottom: 9),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 74,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: productNameTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      // SvgPicture.asset(
                      //   'assets/address-icon.svg',
                      //   width: 14,
                      //   height: 14,
                      // ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      SizedBox(
                        width: 130,
                        child: Text(
                          productCondition,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: kColoredTextStyle,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
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
                ],
              ),
            ],
          ),
          PopupMenuButtonReusable(
            itemBuilder: itemBuilder,
            onSelected: onSelected,
            initialValue: initialValue,
          ),
        ],
      ),
    );
  }
}
