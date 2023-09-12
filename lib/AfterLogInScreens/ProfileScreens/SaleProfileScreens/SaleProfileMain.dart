import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import 'ReviewsScreenSales.dart';
import 'SalesListingsScreen.dart';
import 'SalesProfile.dart';

class SalesProfileMain extends StatefulWidget {
  const SalesProfileMain({super.key});

  @override
  State<SalesProfileMain> createState() => _SalesProfileMainState();
}

class _SalesProfileMainState extends State<SalesProfileMain>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            'Sales Profile',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryBlue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/place-holder.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10,
                    left: -105,
                    child: GestureDetector(
                      onTap: null,
                      child: SvgPicture.asset(
                        'assets/verify-check.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10,
                    bottom: 1,
                    child: GestureDetector(
                      onTap: null,
                      child: SvgPicture.asset(
                        'assets/add-pic-button.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              RatingBar.builder(
                glow: true,
                maxRating: 5,
                tapOnlyMode: true,
                unratedColor: grey,
                glowColor: primaryBlue,
                initialRating: 4,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.zero,
                itemSize: 24,
                itemBuilder: (BuildContext context, int index) {
                  return Icon(
                    Icons.star_rate_rounded,
                    color: Colors.yellow,
                  );
                },
                onRatingUpdate: (double value) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                '(${'70'})',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                // onTap: () => Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => SalesProfile(),
                //   ),
                // ),
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'View Buyer Profile',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryBlue,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
                width: double.infinity,
                height: 70.h,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: TabBar(
                  unselectedLabelColor: grey,
                  // physics: NeverScrollableScrollPhysics(),

                  labelColor: white,

                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: statusOfRide != 1 ? lightGrey : null,
                    gradient: gradient,
                  ),
                  tabs: [
                    Text(
                      'Profile',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Listings',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Reviews',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: tabController,
                  children: [
                    SalesProfile(),
                    SalesListingsScreen(),
                    ReviewsScreenSales(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
