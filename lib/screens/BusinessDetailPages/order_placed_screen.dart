import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/TextfromFieldWidget.dart';

import 'TrackOrderScreen.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  final reviewController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 50,
                child: NavigateBack(
                    buildContext: context,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              ),
              SizedBox(
                height: 60.h,
              ),
              SvgPicture.asset('assets/order-placed.svg'),
              SizedBox(
                height: 60.h,
              ),
              Text(
                'Your Order has been placed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              // RatingBar.builder(
              //   glow: true,
              //   maxRating: 5,
              //   tapOnlyMode: true,
              //   unratedColor: grey,
              //   glowColor: primaryBlue,
              //   initialRating: 4,
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
                height: 30.h,
              ),

              // Padding(
              //   padding: EdgeInsets.only(
              //     bottom: 20,
              //   ),
              //   child: primaryButton(context, 'Track Order', () {
              //     return Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => TrackOrderScreen(),
              //       ),
              //     );
              //   }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
