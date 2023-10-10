import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/utils/Buttons.dart';
import 'package:sellpad/widgets/TextfromFieldWidget.dart';

import '../../widgets/text.dart';
import 'OrderPlacedScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget paymentWidget(String image, String text) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 14),
      width: 145.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryBlue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 7.w,
          ),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          )
        ],
      ),
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
          'Payment',
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
            child: Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: ListView(
                        children: [
                          paymentWidget('assets/paypal.png', 'PayPal'),
                          paymentWidget('assets/Cashup (1).png', 'CashUp'),
                          paymentWidget('assets/zelle.png', 'Zelle'),
                        ],
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Email')),
                    SizedBox(
                      height: 7.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextFormFieldWidget(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(
                          'assets/email-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: 'username@gmail.com',
                        obscureText: null,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Password')),
                    SizedBox(
                      height: 7.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextFormFieldWidget(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        prefixIcon: SvgPicture.asset(
                          'assets/password-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          child: isHidden
                              ? SvgPicture.asset(
                                  'assets/hide-pass-icon.svg',
                                  colorFilter: ColorFilter.mode(
                                      primaryBlue, BlendMode.srcIn),
                                  fit: BoxFit.scaleDown,
                                )
                              : SvgPicture.asset(
                                  'assets/show-pass.svg',
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                      primaryBlue, BlendMode.srcIn),
                                ),
                        ),
                        hintText: '***************',
                        obscureText: isHidden,
                      ),
                    ),
                    SizedBox(
                      height: 400.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderPlacedScreen(),
                          ),
                        ),
                        child: primaryButton(context, 'Continue'),
                      ),
                    ),
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
