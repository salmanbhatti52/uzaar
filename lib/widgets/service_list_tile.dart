import 'package:uzaar/widgets/popup_menu_button.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzaar/utils/colors.dart';

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

class ServiceListTile extends StatelessWidget {
  final String serviceImage;
  final String serviceName;
  final String serviceLocation;
  final String servicePrice;
  final String featuredStatus;
  final void Function(dynamic)? onSelected;
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  final dynamic initialValue;

  const ServiceListTile({
    super.key,
    required this.serviceImage,
    required this.serviceName,
    required this.serviceLocation,
    required this.servicePrice,
    required this.onSelected,
    required this.itemBuilder,
    this.initialValue,
    required this.featuredStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 14),
      padding: const EdgeInsets.only(left: 9, top: 9, bottom: 9),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 74,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    serviceImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 140),
                        child: Text(
                          serviceName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: productNameTextStyle,
                        ),
                      ),
                      featuredStatus == 'Yes'
                          ? const Icon(
                              Icons.bolt,
                              color: Colors.orange,
                            )
                          : const SizedBox()
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
                      SizedBox(
                        width: 130,
                        child: Text(
                          serviceLocation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: locationNameTextStyle,
                        ),
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
                ],
              ),
            ],
          ),
          const Row(
            children: [
              // SvgIcon(imageName: 'assets/edit_list_tile.svg'),
              // SizedBox(width: 6),
              // SvgIcon(imageName: 'assets/del_list_tile.svg'),
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
