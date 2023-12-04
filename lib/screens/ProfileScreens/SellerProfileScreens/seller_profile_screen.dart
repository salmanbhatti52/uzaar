import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import '../../../widgets/business_type_button.dart';
import '../../../widgets/get_stars_tile.dart';
import 'seller_reviews_screen.dart';
import 'seller_listings_screen.dart';
import 'seller_profile_detail_screen.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen>
    with SingleTickerProviderStateMixin {
  int selectedCategory = 1;
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Seller Profile',
          style: kAppBarTitleStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/dummy_profile.png',
                    ),
                  ),
                  Positioned(
                    left: -10,
                    top: -7,
                    child: GestureDetector(
                      onTap: null,
                      child: SvgPicture.asset(
                        'assets/verify-check.svg',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Lisa Fernandes',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 14,
              ),
              StarsTile(
                noOfStars: 5,
                alignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '(${'14'})',
                style: kFontSixteenSixHB,
              ),
              // RatingBar.builder(
              //   glow: true,
              //   maxRating: 5,
              //   tapOnlyMode: true,
              //   unratedColor: grey,
              //   glowColor: primaryBlue,
              //   initialRating: 5,
              //   minRating: 0,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: EdgeInsets.zero,
              //   itemSize: 24,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Icon(
              //       Icons.star_rate_rounded,
              //       color: Colors.yellow,
              //     );
              //   },
              //   onRatingUpdate: (double value) {},
              // ),

              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                // color: f7f8f8,
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
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 1;
                      });
                    },
                    child: BusinessTypeButton(
                        width: 98,
                        businessName: 'Personal Info',
                        gradient: selectedCategory == 1 ? gradient : null,
                        buttonBackground: selectedCategory != 1
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 1 ? white : grey),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 2;
                      });
                    },
                    child: BusinessTypeButton(
                        width: 98,
                        businessName: 'Listings',
                        gradient: selectedCategory == 2 ? gradient : null,
                        buttonBackground: selectedCategory != 2
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 2 ? white : grey),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 3;
                      });
                    },
                    child: BusinessTypeButton(
                        width: 98,
                        businessName: 'Reviews',
                        gradient: selectedCategory == 3 ? gradient : null,
                        buttonBackground: selectedCategory != 3
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 3 ? white : grey),
                  ),
                ],
              ),
              selectedCategory == 1
                  ? SellerProfileDetailScreen()
                  : selectedCategory == 2
                      ? SellerListingsScreen()
                      : SellerReviewsScreen()
              // Container(
              //   padding: EdgeInsets.all(10),
              //   margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
              //   width: double.infinity,
              //   height: 70.h,
              //   decoration: BoxDecoration(
              //     color: white,
              //     borderRadius: BorderRadius.circular(19),
              //   ),
              //   child: TabBar(
              //     unselectedLabelColor: grey,
              //     // physics: NeverScrollableScrollPhysics(),
              //
              //     labelColor: white,
              //
              //     controller: tabController,
              //     indicator: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       // color: statusOfRide != 1 ? lightGrey : null,
              //       gradient: gradient,
              //     ),
              //     tabs: [
              //       Text(
              //         'Profile',
              //         style: GoogleFonts.outfit(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //       Text(
              //         'Listings',
              //         style: GoogleFonts.outfit(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //       Text(
              //         'Reviews',
              //         style: GoogleFonts.outfit(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   child: TabBarView(
              //     physics: BouncingScrollPhysics(),
              //     controller: tabController,
              //     children: [
              //       SalesProfile(),
              //       SalesListingsScreen(),
              //       ReviewsScreenSales(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
