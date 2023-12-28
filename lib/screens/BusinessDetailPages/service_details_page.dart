import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/featured_services_widget.dart';
import '../../widgets/snackbars.dart';
import '../ProfileScreens/SellerProfileScreens/seller_profile_screen.dart';
import '../chat_screen.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({super.key, required this.serviceData});
  final dynamic serviceData;
  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late Set<ReportReason> selectedReasons = {};
  String featuredServicesErrMsg = '';
  Widget HorizontalPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  List aSellerOtherFeaturedServices = [];
  getASellerOtherFeaturedServices() async {
    Response response =
        await sendPostRequest(action: 'get_listings_services', data: {
      'users_customers_id': widget.serviceData['users_customers_id'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    aSellerOtherFeaturedServices = decodedResponse['data'];
    for (var service in aSellerOtherFeaturedServices) {
      if (service['listings_services_id'] ==
          widget.serviceData['listings_services_id']) {
        aSellerOtherFeaturedServices.remove(service);
        break;
      }
    }
    if (aSellerOtherFeaturedServices.isEmpty) {
      featuredServicesErrMsg = 'No more listings found.';
    }
    print('aSellerOtherFeaturedServices: $aSellerOtherFeaturedServices');
  }

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  Future<String?> startChat() async {
    if (userDataGV['userId'] == widget.serviceData['users_customers_id']) {
      return 'yourself';
    }
    setState(() {
      showSpinner = true;
    });
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'startChat',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.serviceData['users_customers_id']
    });
    setState(() {
      showSpinner = false;
    });
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'error') {
      return decodedData['message'];
    }
    return null;
  }

  init() async {
    await getASellerOtherFeaturedServices();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  String? selectedValue;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //     categoryName: widget.serviceData['listings_categories']
                //         ['name'],
                //     image: imgBaseUrl +
                //         widget.serviceData['listings_images'][0]['image']),
                CarouselSlider.builder(
                  itemCount: widget.serviceData['listings_images'].length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Stack(
                    children: [
                      Image.network(
                        imgBaseUrl +
                            widget.serviceData['listings_images'][itemIndex]
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
                              widget.serviceData['listings_categories']['name'],
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
                        widget.serviceData['name'],
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
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.42,
                                child: Text(
                                  widget.serviceData['location'],
                                  style: kSimpleTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
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
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '\$${widget.serviceData['price']}',
                                style: kBodyPrimaryBoldTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Description',
                        style: kBodyHeadingTextStyle,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        widget.serviceData['description'],
                        style: kTextFieldHintStyle,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  color: f7f8f8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String? errorMessage = await startChat();
                          if (errorMessage == null ||
                              errorMessage != 'yourself') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ChatScreen(
                                  otherUserName:
                                      '${widget.serviceData['users_customers']['first_name']} ${widget.serviceData['users_customers']['last_name']}',
                                  otherUserId:
                                      widget.serviceData['users_customers_id'],
                                );
                              },
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'You can only see your listing'));
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
                            const SizedBox(
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

                const SizedBox(
                  height: 14,
                ),

                HorizontalPadding(
                  child: Text(
                    'Seller',
                    style: kBodyHeadingTextStyle,
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                HorizontalPadding(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SellerProfileScreen(),
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
                                    decoration:
                                        widget.serviceData['users_customers']
                                                    ['profile_pic'] !=
                                                null
                                            ? BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      imgBaseUrl +
                                                          widget.serviceData[
                                                                  'users_customers']
                                                              ['profile_pic'],
                                                    )),
                                              )
                                            : const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFD9D9D9),
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
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.serviceData['users_customers']['first_name']} ${widget.serviceData['users_customers']['last_name']}',
                                    style: kBodyTextStyle,
                                  ),
                                  const SizedBox(
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
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          widget.serviceData['users_customers']
                                                  ['address'] ??
                                              '',
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
                              const SizedBox(
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
                const SizedBox(
                  height: 14,
                ),
                HorizontalPadding(
                  child: Text(
                    'Location',
                    style: kBodyHeadingTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                HorizontalPadding(
                  child: Image.asset('assets/details_map.png'),
                ),
                const SizedBox(
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
                    child: aSellerOtherFeaturedServices.isNotEmpty
                        ? ListView.builder(
                            itemCount: aSellerOtherFeaturedServices.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FeaturedServicesWidget(
                                image: imgBaseUrl +
                                    aSellerOtherFeaturedServices[index]
                                        ['listings_images'][0]['image'],
                                serviceCategory:
                                    aSellerOtherFeaturedServices[index]
                                        ['listings_categories']['name'],
                                serviceName: aSellerOtherFeaturedServices[index]
                                    ['name'],
                                serviceLocation:
                                    aSellerOtherFeaturedServices[index]
                                        ['location'],
                                servicePrice:
                                    aSellerOtherFeaturedServices[index]
                                        ['price'],
                                onImageTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ServiceDetailsPage(
                                      serviceData:
                                          aSellerOtherFeaturedServices[index],
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
                        : aSellerOtherFeaturedServices.isEmpty &&
                                featuredServicesErrMsg.isEmpty
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return const FeaturedProductsDummy();
                                  },
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                ))
                            : Center(
                                child: Text(featuredServicesErrMsg),
                              ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // Container(
                //   margin: EdgeInsets.only(bottom: 28),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 22,
                //   ),
                //   child: primaryButton(
                //       context: context,
                //       buttonText: 'Buy Now',
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
    );
  }
}
