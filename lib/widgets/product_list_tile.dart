import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/Colors.dart';

class ProductListTile extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productLocation;
  final String productPrice;

  ProductListTile(
      {required this.productImage,
      required this.productName,
      required this.productLocation,
      required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, left: 5, right: 5, bottom: 5),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(productImage),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/address-icon.svg',
                        width: 14,
                        height: 14,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        productLocation,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: grey,
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
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        productPrice,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryBlue,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.more_vert,
            color: Color(0xff450E8B),
          )
        ],
      ),
    );
  }
}
