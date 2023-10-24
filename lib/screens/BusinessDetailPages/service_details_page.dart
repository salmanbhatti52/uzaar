import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';

import '../../widgets/BottomNaviBar.dart';
import '../../widgets/carousel_builder.dart';
import '../../widgets/featured_services_widget.dart';
import 'paymnet_screen.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({super.key});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  Widget HorizontalPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
            'Service Detail',
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
                // Flexible(
                //   child: ListView.builder(
                //     physics: BouncingScrollPhysics(),
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Image.asset(
                //         'assets/product_detail_img.png',
                //         // width: 200,
                //       );
                //     },
                //   ),
                // ),
                CarouselBuilder(
                    categoryName: 'Designing', imageName: 'service_detail_img'),
                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Graphic Design',
                        style: kBodyHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                        height: 14,
                      ),
                      Text(
                        'Description',
                        style: kBodyHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Neque nulla purus facilisis nibh vestibulum ridiculus non. Imperdiet rhoncus ipsum sed non. Tristique enim blandit ut lorem blandit commodo. Donec ipsum sodales est sed. At id sit morbi at faucibus at.',
                        style: kTextFieldHintStyle,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  color: f7f8f8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/msg-icon.svg',
                              width: 24,
                              height: 24,
                              // fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Start Chat',
                              style: kFontFourteenSixHPB,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 14,
                ),

                HorizontalPadding(
                  child: Text(
                    'Seller',
                    style: kBodyHeadingTextStyle,
                  ),
                ),

                SizedBox(
                  height: 14,
                ),

                HorizontalPadding(
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
                                      width: MediaQuery.of(context).size.width *
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
                HorizontalPadding(
                  child: Text(
                    'Location',
                    style: kBodyHeadingTextStyle,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                HorizontalPadding(
                  child: Image.asset('assets/details_map.png'),
                ),
                SizedBox(
                  height: 14,
                ),
                HorizontalPadding(
                  child: Text(
                    'More by This Seller',
                    style: kBodyHeadingTextStyle,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 22.0,
                    top: 14,
                  ),
                  child: SizedBox(
                    height: 187,
                    child: ListView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FeaturedServicesWidget(
                          image: 'assets/service-ph.png',
                          productCategory: 'Designing',
                          productDescription: 'Graphic Design',
                          productLocation: 'Los Angeles',
                          productPrice: '20',
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 28),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  child: primaryButton(
                    context,
                    'Buy Now',
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
