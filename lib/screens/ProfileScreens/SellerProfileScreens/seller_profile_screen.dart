import 'dart:convert';

import 'package:Uzaar/services/restService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../widgets/business_type_button.dart';
import '../../../widgets/get_stars_tile.dart';
import '../../../widgets/snackbars.dart';
import '../../chat_screen.dart';
import 'seller_reviews_screen.dart';
import 'seller_listings_screen.dart';
import 'seller_profile_detail_screen.dart';

class SellerProfileScreen extends StatefulWidget {
  SellerProfileScreen({super.key, this.sellerData});
  dynamic sellerData;
  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen>
    with SingleTickerProviderStateMixin {
  int selectedCategory = 1;
  late TabController tabController;
  bool showSpinner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    // print('sellerData: ${widget.sellerData}');
  }

  Future<String?> startChat() async {
    if (userDataGV['userId'] == widget.sellerData['users_customers_id']) {
      return 'yourself';
    }
    setState(() {
      showSpinner = true;
    });
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'startChat',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': widget.sellerData['users_customers_id']
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        dismissible: true,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.sellerData['profile_pic'] != null
                            ? Image.network(
                                imgBaseUrl + widget.sellerData['profile_pic'],
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
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
                const SizedBox(
                  height: 14,
                ),
                Text(
                  '${widget.sellerData['first_name']} ${widget.sellerData['last_name']}',
                  style: kBodyHeadingTextStyle,
                ),
                const SizedBox(
                  height: 14,
                ),
                const StarsTile(
                  noOfStars: 5,
                  alignment: MainAxisAlignment.center,
                ),
                const SizedBox(
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

                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  // color: f7f8f8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String? errorMessage = await startChat();
                          print('errorMessage: $errorMessage');
                          if (errorMessage == null ||
                              errorMessage != 'yourself') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ChatScreen(
                                  otherUserName:
                                      '${widget.sellerData['first_name']} ${widget.sellerData['last_name']}',
                                  otherUserId:
                                      widget.sellerData['users_customers_id'],
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
                    ? SellerProfileDetailScreen(
                        sellerData: widget.sellerData,
                      )
                    : selectedCategory == 2
                        ? const SellerListingsScreen()
                        : const SellerReviewsScreen()
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
      ),
    );
  }
}
