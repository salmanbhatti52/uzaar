import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/featured_services_widget.dart';
import 'package:Uzaar/widgets/AddListingsButtonSales.dart';

import 'package:Uzaar/widgets/featured_products_widget.dart';

class SalesListingsScreen extends StatefulWidget {
  const SalesListingsScreen({super.key});

  @override
  State<SalesListingsScreen> createState() => _SalesListingsScreenState();
}

class _SalesListingsScreenState extends State<SalesListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addListingsButtonSales(context, () => null),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Text(
                'Featured Products',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: SizedBox(
                height: 190.h,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return FeaturedProductsWidget(
                      image: 'assets/place-holder.png',
                      productCategory: 'Product Category',
                      productDescription: 'Product Description',
                      productLocation: 'Product Location',
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Text(
                'Featured Products',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, left: 22.w),
              child: SizedBox(
                height: 190.h,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return FeaturedServicesWidget(
                      image: 'assets/place-holder.png',
                      productCategory: 'Product Category',
                      productDescription: 'Product Description',
                      productLocation: 'Product Location',
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
          ],
        ),
      ),
    );
  }
}
