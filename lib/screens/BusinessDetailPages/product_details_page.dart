import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/screens/beforeLoginScreens/signup_screen.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../widgets/BottomNaviBar.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/carousel_builder.dart';
import '../ProfileScreens/SellerProfileScreens/seller_profile_screen.dart';
import '../home_screen.dart';
import 'BottomSheetForSendOffer.dart';
import 'paymnet_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productData});
  final dynamic productData;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Set<ReportReason> selectedReasons = {};

  Widget HorizontalPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  dynamic aSellerOtherFeaturedProducts;

  // To get other featured products of a user. Not confirm now
  getASellerOtherFeaturedProducts() async {
    Response response =
        await sendPostRequest(action: 'get_listings_products', data: {
      'users_customers_id': widget.productData['users_customers_id'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    aSellerOtherFeaturedProducts = decodedResponse['data'];
    print('aSellerOtherFeaturedProducts: $aSellerOtherFeaturedProducts');
  }

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  init() async {
    await getASellerOtherFeaturedProducts();
    setState(() {});
  }

  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

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
            'Product Detail',
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
                    categoryName: widget.productData['listings_categories']
                        ['name'],
                    image: imgBaseUrl +
                        widget.productData['listings_images'][0]['image']),
                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productData['name'],
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
                                'California',
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
                                '\$${widget.productData['price']}',
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
                        widget.productData['description'],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: BottomSheetForSendOffer()),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/send-offer-icon.svg',
                              width: 24,
                              height: 24,
                              // fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Send Offer',
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
                  child: GestureDetector(
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
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              imgBaseUrl +
                                                  widget.productData[
                                                          'users_customers']
                                                      ['profile_pic'],
                                            ))),
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
                                    '${widget.productData['users_customers']['first_name']} ${widget.productData['users_customers']['last_name']}',
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          widget.productData['users_customers']
                                              ['address'],
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
                    child: aSellerOtherFeaturedProducts != null
                        ? ListView.builder(
                            itemCount: aSellerOtherFeaturedProducts.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FeaturedProductsWidget(
                                productCondition:
                                    aSellerOtherFeaturedProducts[index]
                                        ['condition'],
                                image: imgBaseUrl +
                                    aSellerOtherFeaturedProducts[index]
                                        ['listings_images'][0]['image'],
                                productCategory:
                                    aSellerOtherFeaturedProducts[index]
                                        ['listings_categories']['name'],
                                productName: aSellerOtherFeaturedProducts[index]
                                    ['name'],
                                productLocation: 'California',
                                productPrice:
                                    aSellerOtherFeaturedProducts[index]
                                        ['price'],
                                onImageTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        productData:
                                            aSellerOtherFeaturedProducts[index],
                                      ),
                                    ),
                                  );
                                },
                                onOptionTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter stateSetterObject) {
                                        return AlertDialogReusable(
                                          description:
                                              'Select any reason to report. We will show you less listings like this next time.',
                                          title: 'Report Listing',
                                          itemsList: [
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  'Not Interested',
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .notInterested);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(selectedReasons
                                                          .contains(ReportReason
                                                              .notInterested)
                                                      ? 'assets/selected_check.svg'
                                                      : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  'Not Authentic',
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .notAuthentic);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
                                                              ReportReason
                                                                  .notAuthentic)
                                                          ? 'assets/selected_check.svg'
                                                          : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  'Inappropriate',
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason
                                                              .inappropriate);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(selectedReasons
                                                          .contains(ReportReason
                                                              .inappropriate)
                                                      ? 'assets/selected_check.svg'
                                                      : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  'Violent or prohibited content',
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason.violent);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
                                                              ReportReason
                                                                  .violent)
                                                          ? 'assets/selected_check.svg'
                                                          : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                              child: ListTile(
                                                title: Text(
                                                  'Other',
                                                  style: kTextFieldInputStyle,
                                                ),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    stateSetterObject(() {
                                                      handleOptionSelection(
                                                          ReportReason.other);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedReasons.contains(
                                                              ReportReason
                                                                  .other)
                                                          ? 'assets/selected_check.svg'
                                                          : 'assets/default_check.svg'),
                                                ),
                                              ),
                                            ),
                                          ],
                                          button: primaryButton(
                                              context: context,
                                              buttonText: 'Send',
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              showLoader: false),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Shimmer.fromColors(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return const FeaturedProductsDummy();
                              },
                              itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                            ),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!),
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
                      context: context,
                      buttonText: 'Buy Now',
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(),
                            ),
                          ),
                      showLoader: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
