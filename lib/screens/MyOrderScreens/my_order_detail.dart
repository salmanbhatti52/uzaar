import 'package:Uzaar/screens/ProfileScreens/SellerProfileScreens/seller_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Colors.dart';
import '../../widgets/carousel_builder.dart';
import '../../widgets/housing_list_tile.dart';

class MyOrderDetailScreen extends StatefulWidget {
  const MyOrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderDetailScreen> createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  String offerStatus = 'Pending';
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
              // CarouselBuilder(categoryName: 'Electronics', image: ''),
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
                        Container(
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
                    Container(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Seller',
                      style: kBodyHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SellerProfileScreen(),
                        ));
                      },
                      child: Container(
                        decoration: kCardBoxDecoration,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/pd_seller.png',
                                      ),
                                    ),
                                    Positioned(
                                      child: SvgPicture.asset(
                                        'assets/verify-check.svg',
                                        width: 19,
                                        height: 19,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lisa Fernandes',
                                      style: kBodyTextStyle,
                                    ),
                                    SizedBox(
                                      height: 4.5,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/address-icon.svg',
                                          width: 14,
                                          height: 14,
                                          // fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            'Los Angeles',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 1,
                                            style: kFontTwelveFourHG,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/star.svg',
                                  height: 17,
                                  width: 17,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '4.5',
                                  style: kBodyTextStyle,
                                ),
                                Text(
                                  '  (14)',
                                  style: kFontFourteenFiveHG,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
