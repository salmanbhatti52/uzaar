import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Colors.dart';
import '../../widgets/carousel_builder.dart';
import '../../widgets/mini_dropdown_menu.dart';
import '../../widgets/profile_info_tile.dart';

class SalesOrderDetailScreen extends StatefulWidget {
  const SalesOrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<SalesOrderDetailScreen> createState() => _SalesOrderDetailScreenState();
}

class _SalesOrderDetailScreenState extends State<SalesOrderDetailScreen> {
  String offerStatus = 'Pending';
  String orderStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  String offeredPrice = '\$120';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/back-arrow-button.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Order Detail',
          style: kAppBarTitleStyle,
        ),
      ),
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: primaryBlue,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              CarouselBuilder(categoryName: 'Electronics', image: ''),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Iphone 14',
                              style: kBodyHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/address-icon.svg',
                                  width: 16,
                                  height: 16,
                                  // fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Los Angeles',
                                  style: kSimpleTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/price-tag.svg',
                              width: 16,
                              height: 16,
                              // fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '\$${'120'}',
                              style: kBodyPrimaryBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              offeredPrice!,
                              style: kFontSixteenSixHPB,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'offered',
                              style: kTextFieldHintStyle,
                            )
                          ],
                        ),
                        RoundedMiniDropdownMenu(
                          width: 115,
                          onSelected: (selectedOffer) {
                            setState(() {
                              offerStatus = selectedOffer;
                            });
                          },
                          initialSelection: offerStatus,
                          dropdownMenuEntries: offerStatuses
                              .map((String value) =>
                                  DropdownMenuEntry(value: value, label: value))
                              .toList(),
                          fillColor: primaryBlue,
                          textStyle: kFontTwelveSixHW,
                          // hintText: 'Products',
                          leadingIconName: null,
                          colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                          // trailingIconName: 'grid_icon',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Order Status',
                      style: kBodyHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedMiniDropdownMenu(
                      width: 115,
                      onSelected: (selectedOffer) {
                        setState(() {
                          orderStatus = selectedOffer;
                        });
                      },
                      initialSelection: orderStatus,
                      dropdownMenuEntries: offerStatuses
                          .map((String value) =>
                              DropdownMenuEntry(value: value, label: value))
                          .toList(),
                      fillColor: primaryBlue,
                      textStyle: kFontTwelveSixHW,
                      // hintText: 'Products',
                      leadingIconName: null,
                      colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                      // trailingIconName: 'grid_icon',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Buyer Details',
                      style: kBodyHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Column(
                      children: [
                        ProfileInfoTile(
                            imageName: 'profile_icon.svg',
                            title: 'Buyer Name',
                            description: 'alaya'),
                        ProfileInfoTile(
                            imageName: 'email-icon.svg',
                            title: 'Email',
                            description: 'alaya223@gamil.com'),
                        ProfileInfoTile(
                            imageName: 'phone-fill.svg',
                            title: 'Contact Number',
                            description: '+1656565565'),
                        ProfileInfoTile(
                            imageName: 'address-icon.svg',
                            title: 'Address',
                            description: 'Los Angelus')
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
