import 'package:Uzaar/screens/ProfileScreens/personal_info_screen.dart';
import 'package:Uzaar/screens/ProfileScreens/profile_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/widgets/TextfromFieldWidget.dart';
import 'package:Uzaar/widgets/text.dart';

import '../../widgets/business_type_button.dart';
import 'SaleProfileScreens/SaleProfileMain.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedCategory = 1;
  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> getStars(int noOfStars) {
    List<Widget> stars = [];
    const space = SizedBox(width: 4);
    final star = SvgPicture.asset('assets/star.svg');
    stars.add(space);
    for (int i = 0; i < noOfStars; i++) {
      stars.add(star);
      stars.add(space);
    }
    return stars;
  }

  final ratingsNumberTextStyle = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: black,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topEnd,
                      child: SvgPicture.asset(
                        'assets/edit_profile.svg',
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      // alignment: Alignment.bottomRight,
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
                              'assets/verified_icon.svg',
                            ),
                          ),
                        ),
                        Positioned(
                          right: -7,
                          bottom: -1,
                          child: GestureDetector(
                            onTap: null,
                            child: SvgPicture.asset(
                              'assets/add-pic-button.svg',
                              // fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getStars(5),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '(14)',
                      style: ratingsNumberTextStyle,
                    ),
                    SizedBox(
                      height: 20,
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
                            width: 100,
                            businessName: 'Personal Info',
                            gradient: selectedCategory == 1 ? gradient : null,
                            buttonBackground: selectedCategory != 1
                                ? grey.withOpacity(0.3)
                                : null,
                            textColor: selectedCategory == 1 ? white : grey,
                          ),
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
                            width: 100,
                            businessName: 'Reviews',
                            gradient: selectedCategory == 2 ? gradient : null,
                            buttonBackground: selectedCategory != 2
                                ? grey.withOpacity(0.3)
                                : null,
                            textColor: selectedCategory == 2 ? white : grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    selectedCategory == 1
                        ? PersonalInfoScreen()
                        : ProfileReviewsScreen()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
