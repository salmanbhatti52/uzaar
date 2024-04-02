import 'dart:convert';

import 'package:uzaar/screens/chat_screen.dart';
import 'package:uzaar/widgets/snackbars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/utils/Buttons.dart';
import 'package:uzaar/widgets/featured_products_widget.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/restService.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../ProfileScreens/SellerProfileScreens/seller_profile_screen.dart';

import 'BottomSheetForSendOffer.dart';


class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productData});
  final dynamic productData;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late String selectedReason = '';
  late int selectedReasonId;
  String setSendReportButtonStatus = 'Send';
  bool setSendReportButtonLoader = false;
  String featuredProductsErrMsg = '';
  Widget HorizontalPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  List<dynamic> aSellerOtherListingProducts = [];

  // To get other featured products of a user. Not confirm now
  getASellerOtherListingProducts() async {
    Response response =
        await sendPostRequest(action: 'get_listings_products', data: {
      'users_customers_id': widget.productData['users_customers_id'],
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    aSellerOtherListingProducts = decodedResponse['data'];
    for (var product in aSellerOtherListingProducts) {
      if (product['listings_products_id'] ==
          widget.productData['listings_products_id']) {
        aSellerOtherListingProducts.remove(product);
        break;
      }
    }
    if (aSellerOtherListingProducts.isEmpty) {
      featuredProductsErrMsg = 'No more listings found.';
    }

    print('aSellerOtherListingProducts: $aSellerOtherListingProducts');
  }

  Future<String?> startChat() async {
    if (userDataGV['userId'] == widget.productData['users_customers_id']) {
      return 'yourself';
    }
    setState(() {
      showSpinner = true;
    });
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'startChat',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.productData['users_customers_id']
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

  Future<String> reportListing({required int listingId, required int listingTypeId, required int listingCategoriesId, required int listingReportReasonId,}) async{
    Response response = await sendPostRequest(action: 'add_listings_reports', data: {
      "listings_id": listingId,
      "listings_types_id": listingTypeId,
      "listings_categories_id": listingCategoriesId,
      "users_customers_id": userDataGV['userId'],
      "listings_reports_reasons_id": listingReportReasonId
    });
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    String status = decodedResponse['status'];
    if(status == 'success'){
      return status;
    }else if(status == 'error'){
      return decodedResponse['message'];
    }else{
      return '';
    }
  }

  init() async {
    await getASellerOtherListingProducts();
    if (mounted) {
      setState(() {});
    }
  }

  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    print(
        'listings_images length: ${widget.productData['listings_images'].length}');
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
          'Product Detail',
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
                CarouselSlider.builder(
                  itemCount: widget.productData['listings_images'].length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Stack(
                    children: [
                      Image.network(
                        imgBaseUrl +
                            widget.productData['listings_images'][itemIndex]
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
                              widget.productData['listings_categories']['name'],
                              style: kFontTenFiveHW,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  options: carouselOptions,
                ),
                // CarouselBuilder(
                //   slideWidget: Stack(
                //     children: [
                //       Image.network(
                //         imgBaseUrl +
                //             widget.productData['listings_images'][0]['image'],
                //         width: MediaQuery.sizeOf(context).width,
                //         fit: BoxFit.cover,
                //       ),
                //       Positioned(
                //         left: 21,
                //         bottom: 21,
                //         child: Container(
                //           width: 70,
                //           height: 24,
                //           decoration: BoxDecoration(
                //             gradient: gradient,
                //             borderRadius: BorderRadius.circular(30),
                //           ),
                //           child: Center(
                //             child: Text(
                //               widget.productData['listings_categories']['name'],
                //               style: kCardTagTextStyle,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // categoryName: widget.productData['listings_categories']
                //     ['name'],
                // image: imgBaseUrl +
                //     widget.productData['listings_images'][0]['image']
                // ),
                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productData['name'],
                            style: kBodyHeadingTextStyle,
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
                                '\$${widget.productData['price']}',
                                style: kBodyPrimaryBoldTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 7.h,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Row(
                      //     //   children: [
                      //     //     SvgPicture.asset(
                      //     //       'assets/address-icon.svg',
                      //     //       width: 16,
                      //     //       height: 16,
                      //     //       // fit: BoxFit.scaleDown,
                      //     //     ),
                      //     //     SizedBox(
                      //     //       width: 4,
                      //     //     ),
                      //     //     Text(
                      //     //       'California',
                      //     //       style: kSimpleTextStyle,
                      //     //     ),
                      //     //   ],
                      //     // ),
                      //     Row(
                      //       children: [
                      //         SvgPicture.asset(
                      //           'assets/price-tag.svg',
                      //           width: 16,
                      //           height: 16,
                      //           // fit: BoxFit.scaleDown,
                      //         ),
                      //         SizedBox(
                      //           width: 4,
                      //         ),
                      //         Text(
                      //           '\$${widget.productData['price']}',
                      //           style: kBodyPrimaryBoldTextStyle,
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
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
                        widget.productData['description'],
                        style: kTextFieldHintStyle,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  color: f7f8f8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      '${widget.productData['users_customers']['first_name']} ${widget.productData['users_customers']['last_name']}',
                                  otherUserId:
                                      widget.productData['users_customers_id'],
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
                      GestureDetector(
                        onTap: () {
                          if (userDataGV['userId'] ==
                              widget.productData['users_customers_id']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'You can only see your listing'));
                          } else {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: BottomSheetForSendOffer(
                                      // buildContext: context,
                                      listingData: widget.productData,
                                    )),
                              ),
                            );
                          }
                        },
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
                        builder: (context) => SellerProfileScreen(
                            sellerData: widget.productData['users_customers']),
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
                                        widget.productData['users_customers']
                                                    ['profile_pic'] !=
                                                null
                                            ? BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      imgBaseUrl +
                                                          widget.productData[
                                                                  'users_customers']
                                                              ['profile_pic'],
                                                    )))
                                            : const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFD9D9D9),
                                              ),
                                  ),
                                  widget.productData['users_customers']
                                              ['badge_verified'] ==
                                          'Yes'
                                      ? Positioned(
                                          child: SvgPicture.asset(
                                            'assets/verify-check.svg',
                                            width: 19,
                                            height: 19,
                                          ),
                                        )
                                      : const Positioned(child: SizedBox()),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.productData['users_customers']['first_name']} ${widget.productData['users_customers']['last_name']}',
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
                                          widget.productData['users_customers']
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
                    height: 180,
                    child: aSellerOtherListingProducts.isNotEmpty
                        ? ListView.builder(
                            itemCount: aSellerOtherListingProducts.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FeaturedProductsWidget(
                                sellerProfileVerified:
                                    aSellerOtherListingProducts[index]
                                        ['users_customers']['badge_verified'],
                                productCondition:
                                    aSellerOtherListingProducts[index]
                                        ['condition'],
                                image: imgBaseUrl +
                                    aSellerOtherListingProducts[index]
                                        ['listings_images'][0]['image'],
                                productCategory:
                                    aSellerOtherListingProducts[index]
                                        ['listings_categories']['name'],
                                productName: aSellerOtherListingProducts[index]
                                    ['name'],
                                // productLocation: 'California',
                                productPrice: aSellerOtherListingProducts[index]
                                    ['price'],
                                onImageTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        productData:
                                            aSellerOtherListingProducts[index],
                                      ),
                                    ),
                                  );
                                },
                                onOptionTap: () {
                                  if(userDataGV['userId'] == aSellerOtherListingProducts[index]['users_customers_id']){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        ErrorSnackBar(
                                            message: 'You can only see your listings'));
                                  }else{
                                    showDialog(
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter stateSetterObject) {
                                          return AlertDialogReusable(
                                            description:
                                            'Select any reason to report. We will show you less listings like this next time.',
                                            title: 'Report Listing',
                                            itemsList:List.generate(
                                              listingsReportReasonsGV
                                                  .length,
                                                  (index) =>
                                                  SizedBox(
                                                    height: 35,
                                                    child: ListTile(
                                                      title: Text(
                                                        listingsReportReasonsGV[
                                                        index]
                                                        ['reason'],
                                                        style:
                                                        kTextFieldInputStyle,
                                                      ),
                                                      leading:
                                                      GestureDetector(
                                                        onTap: () {
                                                          stateSetterObject(
                                                                  () {
                                                                selectedReason =
                                                                listingsReportReasonsGV[index]
                                                                [
                                                                'reason'];
                                                                selectedReasonId = listingsReportReasonsGV[index]['listings_reports_reasons_id'];
                                                              });
                                                        },
                                                        child: SvgPicture.asset(selectedReason ==
                                                            listingsReportReasonsGV[index]
                                                            [
                                                            'reason']
                                                            ? 'assets/selected_check.svg'
                                                            : 'assets/default_check.svg'),
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                            button:  primaryButton(
                                                context: context,
                                                buttonText: setSendReportButtonStatus,
                                                onTap: () async {
                                                  stateSetterObject((){
                                                    setSendReportButtonStatus = 'Please wait..';
                                                    setSendReportButtonLoader = true;
                                                  });
                                                  String apiResponse = await reportListing(
                                                      listingId: aSellerOtherListingProducts[index]['listings_products_id'],
                                                      listingTypeId: aSellerOtherListingProducts[index]['listings_types_id'],
                                                      listingCategoriesId: aSellerOtherListingProducts[index]['listings_categories_id'],
                                                      listingReportReasonId: selectedReasonId
                                                  );

                                                  stateSetterObject((){

                                                    setSendReportButtonStatus = 'Send';
                                                    setSendReportButtonLoader = false;
                                                  });
                                                  if(apiResponse == 'success'){

                                                    ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Listing Reported'));

                                                  }else if(apiResponse.isNotEmpty && apiResponse != 'success'){

                                                    ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: apiResponse));

                                                  }
                                                  Navigator.of(
                                                      context)
                                                      .pop();
                                                },
                                                showLoader: setSendReportButtonLoader),
                                          );
                                        },
                                      ),
                                    );
                                  }

                                },
                              );
                            },
                          )
                        : aSellerOtherListingProducts.isEmpty &&
                                featuredProductsErrMsg.isEmpty
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
                                child: Text(featuredProductsErrMsg),
                              ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // Container(
                //   margin: EdgeInsets.only(bottom: 10),
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
