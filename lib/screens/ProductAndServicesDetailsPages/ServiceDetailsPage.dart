import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/FeaturedProductsWidget.dart';

import 'PaymnetScreen.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({super.key});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  Widget padding(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Service Details',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: black,
          ),
        ),
      ),
      body: SafeArea(
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
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryBlue,
                        ),
                      ),
                      width: double.infinity,
                      height: 200.h,
                      child: Image.asset('assets/place-holder.png'),
                    ),
                    Positioned(
                      left: 5,
                      bottom: 10,
                      child: Container(
                        padding: EdgeInsets.all(3.h),
                        width: 75.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Designing',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                padding(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name of the product',
                        style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: black),
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
                                width: 17.w,
                                height: 17.h,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                'Name of the product',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/price-tag.svg',
                                width: 17.w,
                                height: 17.h,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '\$${'50'}',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryBlue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: null,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/msg-icon.svg',
                                  width: 24.w,
                                  height: 24.h,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Start Chat',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: null,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/send-offer-icon.svg',
                                  width: 32.w,
                                  height: 32.h,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Send Offer',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                padding(
                  Text(
                    'Seller',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                padding(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryBlue,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/place-holder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: -6,
                                child: SvgPicture.asset(
                                  'assets/verify-check.svg',
                                  width: 19.w,
                                  height: 19.h,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seller Name',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/address-icon.svg',
                                    width: 14.w,
                                    height: 14.h,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      'address of the seller address of the seller address of the seller address of the seller',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 1,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: grey,
                                      ),
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
                          Icon(
                            Icons.star_rate_rounded,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          Text(
                            '4.5',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                          Text(
                            '  (13)',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                padding(
                  Text(
                    'Location',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                padding(
                  Container(
                    width: double.infinity,
                    height: 155.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: primaryBlue,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/place-holder.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                padding(
                  Text(
                    'More by This Seller',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FeaturedProductsWidget(
                          image: 'assets/place-holder.png',
                          productCategory: 'Designing',
                          productDescription: 'productDescription',
                          productLocation: 'productLocation',
                          productPrice: 'productPrice');
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                padding(
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.h),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
