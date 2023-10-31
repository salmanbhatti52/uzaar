import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';
import 'package:Uzaar/widgets/AddListingsButtonSales.dart';

import 'package:Uzaar/widgets/featured_products_widget.dart';

import '../../BusinessDetailPages/product_details_page.dart';
import '../../BusinessDetailPages/service_details_page.dart';

class SellerListingsScreen extends StatefulWidget {
  const SellerListingsScreen({super.key});

  @override
  State<SellerListingsScreen> createState() => _SellerListingsScreenState();
}

class _SellerListingsScreenState extends State<SellerListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Featured Products',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 187,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(),
                        ),
                      ),
                      child: FeaturedProductsWidget(
                        image: 'assets/product-ph.png',
                        productCategory: 'Electronics',
                        productDescription: 'Iphone 14',
                        productLocation: 'Los Angeles',
                        productPrice: '120',
                      ),
                    );
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Featured Services',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 187,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailsPage(),
                    ),
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return FeaturedServicesWidget(
                        image: 'assets/service-ph.png',
                        productCategory: 'Designing',
                        productDescription: 'Graphic Design',
                        productLocation: 'Los Angeles',
                        productPrice: '20',
                      );
                    },
                    itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
