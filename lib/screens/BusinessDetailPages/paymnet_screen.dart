import 'dart:convert';

import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/text_form_field_reusable.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../services/restService.dart';
import '../../widgets/payment_button.dart';
import '../../widgets/text.dart';
import 'order_placed_screen.dart';
import 'package:shimmer/shimmer.dart';

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
  late String selectedPaymentMethod;
  bool showSpinner = false;
  dynamic paymentMethods;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentMethods();
  }

  getPaymentMethods() async {
    // setState(() {
    //   showSpinner = true;
    // });
    Response response = await sendGetRequest('get_payment_gateways');

    print(response.statusCode);
    print(response.body);
    paymentMethods = jsonDecode(response.body);
    setState(() {
      selectedPaymentMethod = paymentMethods?['data'][0]['name'];
      // showSpinner = false;
    });
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
        body: ModalProgressHUD(
          color: Colors.white,
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: primaryBlue,
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 22),
                        height: 54,
                        child: ListView(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: paymentMethods != null
                              ? List.generate(
                                  paymentMethods?['data'].length,
                                  (index) => paymentWidget(
                                      margin: EdgeInsets.only(right: 10),
                                      onTap: () {
                                        setState(() {
                                          selectedPaymentMethod =
                                              paymentMethods?['data'][index]
                                                  ['name'];
                                        });
                                      },
                                      image: paymentMethods?['data'][index]
                                                  ['name'] ==
                                              'PayPal'
                                          ? 'assets/paypal_logo.png'
                                          : paymentMethods?['data'][index]
                                                      ['name'] ==
                                                  'Zelle'
                                              ? 'assets/zelle_logo.png'
                                              : 'assets/cash_app.png',
                                      text: paymentMethods?['data'][index]
                                          ['name'],
                                      decoration: selectedPaymentMethod ==
                                              paymentMethods?['data'][index]
                                                  ['name']
                                          ? kCardBoxBorder
                                          : kCardBoxDecoration),
                                )
                              : [
                                  Shimmer.fromColors(
                                      child: ListView.builder(
                                        itemCount: 3,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(right: 10),
                                            width: 146,
                                            height: 54,
                                            decoration:
                                                kCardBoxDecoration.copyWith(
                                                    color:
                                                        grey.withOpacity(0.3)),
                                          );
                                        },
                                      ),
                                      baseColor: Colors.grey[500]!,
                                      highlightColor: Colors.grey[100]!),
                                ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                prefixIcon: SvgIcon(
                                    imageName: 'assets/password-icon.svg'),
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
                                          imageName:
                                              'assets/hide-pass-icon.svg',
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
                                  context: context,
                                  buttonText: 'Continue',
                                  onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderPlacedScreen(),
                                        ),
                                      ),
                                  showLoader: false),
                            ),
                          ],
                        ),
                      )
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
