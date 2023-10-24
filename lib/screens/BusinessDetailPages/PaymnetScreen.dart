import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/Colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/TextfromFieldWidget.dart';

import '../../widgets/payment_button.dart';
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

  bool isHidden = true;
  bool paypalMethod = true;
  bool zelleMethod = false;
  bool cashUpMethod = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        backgroundColor: Colors.white,
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
            style: kAppBarTitleStyle,
          ),
        ),
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 22.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 54,
                        child: ListView(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            paymentWidget(
                                onTap: () {
                                  setState(() {
                                    paypalMethod = true;
                                    zelleMethod = false;
                                    cashUpMethod = false;
                                  });
                                },
                                image: 'assets/paypal_logo.png',
                                text: 'PayPal',
                                decoration: paypalMethod
                                    ? kCardBoxBorder
                                    : kCardBoxDecoration),
                            SizedBox(
                              width: 10,
                            ),
                            paymentWidget(
                                onTap: () {
                                  setState(() {
                                    paypalMethod = false;
                                    zelleMethod = true;
                                    cashUpMethod = false;
                                  });
                                },
                                image: 'assets/zelle_logo.png',
                                text: 'Zelle',
                                decoration: zelleMethod
                                    ? kCardBoxBorder
                                    : kCardBoxDecoration),
                            SizedBox(
                              width: 10,
                            ),
                            paymentWidget(
                                onTap: () {
                                  setState(() {
                                    paypalMethod = false;
                                    zelleMethod = false;
                                    cashUpMethod = true;
                                  });
                                },
                                image: 'assets/cashup_logo.png',
                                text: 'CashUp',
                                decoration: cashUpMethod
                                    ? kCardBoxBorder
                                    : kCardBoxDecoration),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Email')),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 46,
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
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(text: 'Password')),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/password-icon.svg'),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: isHidden
                                ? SvgIcon(
                                    imageName: 'assets/show-pass.svg',
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                  )
                                : SvgIcon(
                                    imageName: 'assets/hide-pass-icon.svg',
                                    colorFilter: ColorFilter.mode(
                                        primaryBlue, BlendMode.srcIn),
                                  ),
                          ),
                          hintText: '***************',
                          obscureText: isHidden,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: primaryButton(
                          context,
                          'Continue',
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OrderPlacedScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
