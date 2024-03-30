import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import '../../services/restService.dart';
import '../../utils/Colors.dart';

import '../../widgets/mini_dropdown_menu.dart';
import '../../widgets/profile_info_tile.dart';
import '../../widgets/snackbars.dart';

class SalesOrderDetailScreen extends StatefulWidget {
  SalesOrderDetailScreen({super.key, required this.orderData});
  dynamic orderData;
  @override
  State<SalesOrderDetailScreen> createState() => _SalesOrderDetailScreenState();
}

class _SalesOrderDetailScreenState extends State<SalesOrderDetailScreen> {
  String offerStatus = '';
  String orderStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  // String offeredPrice = '\$120';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerStatus = widget.orderData['status'];
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop(offerStatus);
        return true;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(offerStatus),
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
                CarouselSlider.builder(
                  itemCount: widget
                      .orderData['listings_products']['listings_images'].length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) =>
                          Stack(
                    children: [
                      Image.network(
                        imgBaseUrl +
                            widget.orderData['listings_products']
                                ['listings_images'][itemIndex]['image'],
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
                              widget.orderData['listings_products']
                                  ['listings_categories']['name'],
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
                                widget.orderData['listings_products']['name'],
                                style: kBodyHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(
                              //       'assets/address-icon.svg',
                              //       width: 16,
                              //       height: 16,
                              //       // fit: BoxFit.scaleDown,
                              //     ),
                              //     const SizedBox(
                              //       width: 4,
                              //     ),
                              //     Text(
                              //       'Los Angeles',
                              //       style: kSimpleTextStyle,
                              //     ),
                              //   ],
                              // ),
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
                                '\$${widget.orderData['listings_products']['price']}',
                                style: kBodyPrimaryBoldTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${widget.orderData['offer_price']}',
                                style: kFontSixteenSixHPB,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                'offered',
                                style: kTextFieldHintStyle,
                              )
                            ],
                          ),
                          offerStatus == 'Pending'
                              ? RoundedMiniDropdownMenu(
                                  enabled: true,
                                  width: 115,
                                  onSelected: (selectedOffer) async {

                                    setState(() {
                                      offerStatus = selectedOffer;
                                      // selectedOffer = index;
                                    });
                                    if (selectedOffer == 'Accept') {
                                      Response response = await sendPostRequest(
                                          action: 'accept_sales_listings_orders_offers',
                                          data: {
                                            'listings_orders_id':
                                            widget.orderData
                                            ['listings_orders_id'],
                                            'listings_id':
                                            widget.orderData
                                            ['listings_id'],
                                            'listings_types_id':
                                            widget.orderData
                                            ['listings_types_id'],
                                            'listings_categories_id':
                                            widget.orderData
                                            ['listings_categories_id'],
                                            'users_customers_id':
                                            widget.orderData
                                            ['users_customers_id']
                                          });
                                      print(response.statusCode);
                                      print(response.body);
                                      var decodedData = jsonDecode(response.body);
                                      String status = decodedData['status'];
                                      if (status == 'success') {
                                        setState(() {
                                          offerStatus = 'Accepted';
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SuccessSnackBar(
                                                  message: 'Offer Accepted'));
                                        });
                                      }
                                      if (status == 'error') {
                                        String message = decodedData['message'];
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            ErrorSnackBar(message: message));
                                        // selectedIndex = null;
                                      }
                                    }
                                    if (selectedOffer == 'Reject') {
                                      Response response = await sendPostRequest(
                                          action: 'reject_sales_listings_orders_offers',
                                          data: {
                                            'listings_orders_id':
                                            widget.orderData
                                            ['listings_orders_id'],
                                            'listings_id':
                                            widget.orderData
                                            ['listings_id'],
                                            'listings_types_id':
                                            widget.orderData
                                            ['listings_types_id'],
                                            'listings_categories_id':
                                            widget.orderData
                                            ['listings_categories_id'],
                                            'users_customers_id':
                                            widget.orderData
                                            ['users_customers_id']
                                          });
                                      print(response.statusCode);
                                      print(response.body);
                                      var decodedData = jsonDecode(response.body);
                                      String status = decodedData['status'];
                                      if (status == 'success') {
                                        setState(() {
                                          offerStatus = 'Rejected';
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SuccessSnackBar(
                                                  message: 'Offer Rejected'));
                                        });
                                      }
                                      if (status == 'error') {
                                        String message = decodedData['message'];
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            ErrorSnackBar(message: message));
                                        // selectedIndex = null;
                                      }
                                    }
                                  },
                                  initialSelection: offerStatus,
                                  dropdownMenuEntries: offerStatuses
                                      .map((String value) => DropdownMenuEntry(
                                          value: value, label: value))
                                      .toList(),
                                  fillColor: primaryBlue,
                                  textStyle: kFontTwelveSixHW,
                                  // hintText: 'Products',
                                  leadingIconName: null,
                                  colorFilter: const ColorFilter.mode(
                                      white, BlendMode.srcIn),
                                  // trailingIconName: 'grid_icon',
                                )
                              : Container(
                                  width: 80,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: offerStatus == 'Accepted'
                                        ? lightGreen
                                        : offerStatus == 'Rejected'
                                            ? red
                                            : offerStatus == 'Dispatched'
                                                ? black
                                                : black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      offerStatus,
                                      style: kFontTwelveSixHW,
                                    ),
                                  ),
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Order Status',
                        style: kBodyHeadingTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      offerStatus == 'Pending'
                          ? RoundedMiniDropdownMenu(
                        enabled: true,
                        width: 115,
                        onSelected: (selectedOffer) async {

                          setState(() {
                            offerStatus = selectedOffer;
                            // selectedOffer = index;
                          });
                          if (selectedOffer == 'Accept') {
                            Response response = await sendPostRequest(
                                action: 'accept_sales_listings_orders_offers',
                                data: {
                                  'listings_orders_id':
                                  widget.orderData
                                  ['listings_orders_id'],
                                  'listings_id':
                                  widget.orderData
                                  ['listings_id'],
                                  'listings_types_id':
                                  widget.orderData
                                  ['listings_types_id'],
                                  'listings_categories_id':
                                  widget.orderData
                                  ['listings_categories_id'],
                                  'users_customers_id':
                                  widget.orderData
                                  ['users_customers_id']
                                });
                            print(response.statusCode);
                            print(response.body);
                            var decodedData = jsonDecode(response.body);
                            String status = decodedData['status'];
                            if (status == 'success') {
                              setState(() {
                                offerStatus = 'Accepted';
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SuccessSnackBar(
                                        message: 'Offer Accepted'));
                              });
                            }
                            if (status == 'error') {
                              String message = decodedData['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ErrorSnackBar(message: message));
                              // selectedIndex = null;
                            }
                          }
                          if (selectedOffer == 'Reject') {
                            Response response = await sendPostRequest(
                                action: 'reject_sales_listings_orders_offers',
                                data: {
                                  'listings_orders_id':
                                  widget.orderData
                                  ['listings_orders_id'],
                                  'listings_id':
                                  widget.orderData
                                  ['listings_id'],
                                  'listings_types_id':
                                  widget.orderData
                                  ['listings_types_id'],
                                  'listings_categories_id':
                                  widget.orderData
                                  ['listings_categories_id'],
                                  'users_customers_id':
                                  widget.orderData
                                  ['users_customers_id']
                                });
                            print(response.statusCode);
                            print(response.body);
                            var decodedData = jsonDecode(response.body);
                            String status = decodedData['status'];
                            if (status == 'success') {
                              setState(() {
                                offerStatus = 'Rejected';
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SuccessSnackBar(
                                        message: 'Offer Rejected'));
                              });
                            }
                            if (status == 'error') {
                              String message = decodedData['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ErrorSnackBar(message: message));
                              // selectedIndex = null;
                            }
                          }
                        },
                        initialSelection: offerStatus,
                        dropdownMenuEntries: offerStatuses
                            .map((String value) => DropdownMenuEntry(
                            value: value, label: value))
                            .toList(),
                        fillColor: primaryBlue,
                        textStyle: kFontTwelveSixHW,
                        // hintText: 'Products',
                        leadingIconName: null,
                        colorFilter: const ColorFilter.mode(
                            white, BlendMode.srcIn),
                        // trailingIconName: 'grid_icon',
                      )
                          : Container(
                        width: 80,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: offerStatus == 'Accepted'
                              ? lightGreen
                              : offerStatus == 'Rejected'
                              ? red
                              : offerStatus == 'Dispatched'
                              ? black
                              : black,
                        ),
                        child: Center(
                          child: Text(
                            offerStatus,
                            style: kFontTwelveSixHW,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Buyer Details',
                        style: kBodyHeadingTextStyle,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Column(
                        children: [
                          ProfileInfoTile(
                              imageName: 'profile_icon.svg',
                              title: 'Buyer Name',
                              description:  widget.orderData['users_customers']['first_name'] + ' ' + widget.orderData['users_customers']['last_name'] ),
                          ProfileInfoTile(
                              imageName: 'email-icon.svg',
                              title: 'Email',
                              description: widget.orderData['users_customers']['email']),
                          ProfileInfoTile(
                              imageName: 'phone-fill.svg',
                              title: 'Contact Number',
                              description: widget.orderData['users_customers']?['phone'] ?? ''),
                          ProfileInfoTile(
                              imageName: 'address-icon.svg',
                              title: 'Address',
                              description: widget.orderData['users_customers']?['address'] ?? '')
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
