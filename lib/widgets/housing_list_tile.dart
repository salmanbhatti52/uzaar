import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/Colors.dart';

import 'housing_icon_text_widget.dart';

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

class HousingListTile extends StatelessWidget {
  final String houseImage;
  final String houseName;
  final String houseLocation;
  final String housePrice;
  final String houseType;
  final String houseArea;
  final String noOfBeds;
  final String noOfBaths;

  const HousingListTile({
    required this.houseImage,
    required this.houseName,
    required this.houseLocation,
    required this.housePrice,
    required this.houseArea,
    required this.houseType,
    required this.noOfBaths,
    required this.noOfBeds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 14),
      padding: EdgeInsets.all(9),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(houseImage),
              SizedBox(
                width: 8.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    houseName,
                    style: productNameTextStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    houseType,
                    style: houseTypeTextStyle,
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
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        houseLocation,
                        style: locationNameTextStyle,
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
                        housePrice,
                        style: priceTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HousingIconTextWidget(
                        imageName: 'area_icon',
                        text: '$houseArea sq.mt',
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      HousingIconTextWidget(
                        imageName: 'bath_icon',
                        text: noOfBaths,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      HousingIconTextWidget(
                        imageName: 'bed_icon',
                        text: noOfBeds,
                      ),
                    ],
                  )
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
