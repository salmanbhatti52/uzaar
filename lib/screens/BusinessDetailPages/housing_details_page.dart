import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../widgets/BottomNaviBar.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/featured_housing_widget.dart';
import '../../widgets/featured_products_widget.dart';
import '../../widgets/icon_text_combo.dart';
import '../ProfileScreens/SellerProfileScreens/seller_profile_screen.dart';
import '../chat_screen.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class HousingDetailsPage extends StatefulWidget {
  const HousingDetailsPage({Key? key, required this.houseData})
      : super(key: key);
  final dynamic houseData;
  @override
  State<HousingDetailsPage> createState() => _HousingDetailsPageState();
}

class _HousingDetailsPageState extends State<HousingDetailsPage> {
  late Set<ReportReason> selectedReasons = {};
  Widget HorizontalPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  dynamic aSellerOtherFeaturedHouses;
  getASellerOtherFeaturedHouses() async {
    Response response =
        await sendPostRequest(action: 'get_listings_housings', data: {
      'users_customers_id': widget.houseData['users_customers_id'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    aSellerOtherFeaturedHouses = decodedResponse['data'];
    print('aSellerOtherFeaturedHouses: $aSellerOtherFeaturedHouses');
  }

  Future<String> startChat() async {
    setState(() {
      showSpinner = true;
    });
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'startChat',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.houseData['users_customers_id']
    });
    setState(() {
      showSpinner = false;
    });
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    return status;
  }

  bool showSpinner = false;

  init() async {
    await getASellerOtherFeaturedHouses();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
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
            'Housing Detail',
            style: kAppBarTitleStyle,
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          dismissible: true,
          color: Colors.white,
          child: GlowingOverscrollIndicator(
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
                  // CarouselBuilder(
                  //     categoryName: widget.houseData['listings_categories']
                  //         ['name'],
                  //     image: imgBaseUrl +
                  //         widget.houseData['listings_images'][0]['image']),
                  CarouselSlider.builder(
                    itemCount: widget.houseData['listings_images'].length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Stack(
                      children: [
                        Image.network(
                          imgBaseUrl +
                              widget.houseData['listings_images'][itemIndex]
                                  ['image'],
                          width: MediaQuery.sizeOf(context).width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 21,
                          bottom: 21,
                          child: Container(
                            width: 70,
                            height: 24,
                            decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                widget.houseData['listings_categories']['name'],
                                style: kFontTenFiveHW,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    options: carouselOptions,
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.houseData['name'],
                          style: kBodyHeadingTextStyle,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.42,
                                    child: Text(
                                      widget.houseData['location'],
                                      style: kSimpleTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
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
                                  '\$${widget.houseData['price']}',
                                  style: kBodyPrimaryBoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconTextReusable(
                              imageName: 'area_icon',
                              text: '${widget.houseData['area']} sq.ft',
                              height: 16,
                              width: 16,
                              style: kSimpleTextStyle,
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            IconTextReusable(
                              imageName: 'bath_icon',
                              text: widget.houseData['bathroom'],
                              height: 16,
                              width: 16,
                              style: kSimpleTextStyle,
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            IconTextReusable(
                              imageName: 'bed_icon',
                              text: widget.houseData['bedroom'],
                              height: 16,
                              width: 16,
                              style: kSimpleTextStyle,
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
                          widget.houseData['description'],
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
                          onTap: () async {
                            String status = await startChat();
                            if (status.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ChatScreen(
                                    otherUserId:
                                        widget.houseData['users_customers_id'],
                                  );
                                },
                              ));
                            }
                          },
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
                                                  widget.houseData[
                                                          'users_customers']
                                                      ['profile_pic'],
                                            )),
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
                                      '${widget.houseData['users_customers']['first_name']} ${widget.houseData['users_customers']['last_name']}',
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
                                            widget.houseData['users_customers']
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
                      height: 206,
                      child: aSellerOtherFeaturedHouses != null
                          ? ListView.builder(
                              itemCount: aSellerOtherFeaturedHouses.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return FeaturedHousingWidget(
                                  furnishedStatus:
                                      aSellerOtherFeaturedHouses[index]
                                                  ['furnished'] ==
                                              'Yes'
                                          ? 'Furnished'
                                          : 'Not Furnished',
                                  image: imgBaseUrl +
                                      aSellerOtherFeaturedHouses[index]
                                          ['listings_images'][0]['image'],
                                  housingCategory:
                                      aSellerOtherFeaturedHouses[index]
                                          ['listings_categories']['name'],
                                  housingName: aSellerOtherFeaturedHouses[index]
                                      ['name'],
                                  housingLocation:
                                      aSellerOtherFeaturedHouses[index]['name'],
                                  housingPrice:
                                      aSellerOtherFeaturedHouses[index]
                                          ['price'],
                                  area: aSellerOtherFeaturedHouses[index]
                                      ['area'],
                                  bedrooms: aSellerOtherFeaturedHouses[index]
                                      ['bedroom'],
                                  bathrooms: aSellerOtherFeaturedHouses[index]
                                      ['bathroom'],
                                  onImageTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => HousingDetailsPage(
                                        houseData:
                                            aSellerOtherFeaturedHouses[index],
                                      ),
                                    ));
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
                                                      style:
                                                          kTextFieldInputStyle,
                                                    ),
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(() {
                                                          handleOptionSelection(
                                                              ReportReason
                                                                  .notInterested);
                                                        });
                                                      },
                                                      child: SvgPicture.asset(
                                                          selectedReasons.contains(
                                                                  ReportReason
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
                                                      style:
                                                          kTextFieldInputStyle,
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
                                                      style:
                                                          kTextFieldInputStyle,
                                                    ),
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(() {
                                                          handleOptionSelection(
                                                              ReportReason
                                                                  .inappropriate);
                                                        });
                                                      },
                                                      child: SvgPicture.asset(
                                                          selectedReasons.contains(
                                                                  ReportReason
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
                                                      style:
                                                          kTextFieldInputStyle,
                                                    ),
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(() {
                                                          handleOptionSelection(
                                                              ReportReason
                                                                  .violent);
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
                                                      style:
                                                          kTextFieldInputStyle,
                                                    ),
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        stateSetterObject(() {
                                                          handleOptionSelection(
                                                              ReportReason
                                                                  .other);
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
                                                      Navigator.of(context)
                                                          .pop(),
                                                  showLoader: false));
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
                    height: 25,
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(bottom: 28),
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 22,
                  //   ),
                  //   child: primaryButton(
                  //       context: context,
                  //       buttonText: widget.houseData['listings_categories']
                  //                   ['name'] ==
                  //               'For Sale'
                  //           ? 'Buy Now'
                  //           : 'Reserve Now',
                  //       onTap: () => Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //               builder: (context) => PaymentScreen(),
                  //             ),
                  //           ),
                  //       showLoader: false),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
