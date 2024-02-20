import 'dart:convert';

import 'package:uzaar/widgets/BottomNaviBar.dart';
import 'package:uzaar/widgets/suffix_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/utils/Buttons.dart';
import 'package:uzaar/widgets/text_form_field_reusable.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../services/restService.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/payment_button.dart';
import '../../widgets/text.dart';
import '../BeforeLoginScreens/signup_screen.dart';
import 'order_placed_screen.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({
    super.key,
    // required this.listingItemId,
    // required this.packageId,
    this.userCustomerPackagesId,
    this.listingItemId,
    this.selectedPackage,
    // this.packagePrice
    // this.userCustomerPackagesId,
  });
  int? listingItemId;
  Map? selectedPackage;
  // double? packagePrice;
   int? userCustomerPackagesId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isHidden = true;
  late String selectedPaymentMethod;
   int selectedPaymentMethodId = 1;
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
      selectedPaymentMethodId =
          paymentMethods?['data'][0]['payment_gateways_id'];
      // showSpinner = false;
    });
  }

  payWithPayPal({required String paymentStatus, required String payerEmail, required String payeeEmail, required String payerName, required String paymentId}) async{
    
    print(widget.selectedPackage);
    print(widget.userCustomerPackagesId);

    int? packagesId;
    int? usersCustomersPackagesId;

    if(widget.userCustomerPackagesId != null){
      usersCustomersPackagesId = widget.userCustomerPackagesId;
      packagesId = null;
    }else{
      packagesId = widget.selectedPackage?['packages_id'];
      usersCustomersPackagesId = null;
    }

    Response response = await sendPostRequest(action: 'boost_listings_products_by_paypal',data: {
      "listings_products_id": widget.listingItemId,
      "packages_id": packagesId,
      "users_customers_packages_id": usersCustomersPackagesId,
      "payment_gateways_id": selectedPaymentMethodId,
      // "payment_status": "Paid",
      "payment_status": paymentStatus,
      "payer_email": payerEmail,
      "payer_name": payerName,
      "payee_email": payeeEmail,
      "total_amount": widget.selectedPackage?['price'],
      "token_id": paymentId
    });

    print('boos listing Res: ${response.body}');

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBar(requiredScreenIndex: 0)),
        );
        return false;
      },
      child: GestureDetector(
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
              onTap: () {
                // showDialog(context: context, builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialogReusable(
                //   title: 'Can not Complete Action',
                //   description:
                //   'You can not sell anything on platform in guest mode. Signup now if you want to list any item.',
                //   button: primaryButton(
                //     context: context,
                //     buttonText: 'Signup',
                //     onTap: () =>
                //         Navigator.pushReplacement(context, MaterialPageRoute(
                //           builder: (context) {
                //             return const SignUpScreen();
                //           },
                //         )),
                //     showLoader: false,
                //   ),
                // ),),);
                // Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BottomNavBar(requiredScreenIndex: 0)),
                );
              },
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 22),
                          height: 54,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: paymentMethods != null
                                ? List.generate(
                                    paymentMethods?['data'].length,
                                    (index) => paymentWidget(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        onTap: () {
                                          setState(() {
                                            selectedPaymentMethod =
                                                paymentMethods?['data'][index]
                                                    ['name'];
                                            selectedPaymentMethodId =
                                                paymentMethods?['data'][index]
                                                    ['payment_gateways_id'];
                                            print(selectedPaymentMethodId);
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
                                        baseColor: Colors.grey[500]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: ListView.builder(
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 146,
                                              height: 54,
                                              decoration:
                                                  kCardBoxDecoration.copyWith(
                                                      color: grey
                                                          .withOpacity(0.3)),
                                            );
                                          },
                                        )),
                                  ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectedPaymentMethodId != 1
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: ReusableText(text: 'Email')),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 46,
                                          child: TextFormFieldWidget(
                                            focusedBorder:
                                                kRoundedActiveBorderStyle,
                                            controller: emailController,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            prefixIcon: SvgPicture.asset(
                                              'assets/email-icon.svg',
                                              fit: BoxFit.scaleDown,
                                            ),
                                            hintText: 'username@gmail.com',
                                            obscureText: null,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child:
                                                ReusableText(text: 'Password')),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 46,
                                          child: TextFormFieldWidget(
                                            focusedBorder:
                                                kRoundedActiveBorderStyle,
                                            controller: passwordController,
                                            textInputType:
                                                TextInputType.visiblePassword,
                                            prefixIcon: const SvgIcon(
                                                imageName:
                                                    'assets/password-icon.svg'),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isHidden = !isHidden;
                                                });
                                              },
                                              child: isHidden
                                                  ? const SvgIcon(
                                                      imageName:
                                                          'assets/show-pass.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              primaryBlue,
                                                              BlendMode.srcIn),
                                                    )
                                                  : const SvgIcon(
                                                      imageName:
                                                          'assets/hide-pass-icon.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              primaryBlue,
                                                              BlendMode.srcIn),
                                                    ),
                                            ),
                                            hintText: '***************',
                                            obscureText: isHidden,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.33,
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: primaryButton(
                                    context: context,
                                    buttonText: 'Continue',
                                    onTap: () async {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PaypalCheckout(
                                      //       note: "PAYMENT_NOTE",
                                      //       onSuccess: (Map params) async {
                                      //         // print("onSuccess: $params");
                                      //         // var data = jsonEncode(params);
                                      //         print("onSuccess123: $params");
                                      //         payWithPayPal(
                                      //           payeeEmail: params['data']['transactions'][0]['payee']['email'],
                                      //           payerEmail: params['data']['payer']['payer_info']['email'],
                                      //           payerName: params['data']['payer']['payer_info']['first_name'] + " " + params['data']['payer']['payer_info']['last_name'] ,
                                      //           paymentId: params['data']['transactions'][0]['related_resources'][0]['sale']['id'],paymentStatus: 'Paid',
                                      //           // paymentId: params['data']['transactions'][0]['related_resources'][0]['sale']['id'],paymentStatus: params['data']['transactions'][0]['related_resources'][0]['sale']['state'],
                                      //         );
                                      //       },
                                      //       onError: (error) {
                                      //         print("onError: $error");
                                      //         Navigator.pop(context);
                                      //       },
                                      //       onCancel: () {
                                      //         print('cancelled:');
                                      //       },
                                      //       sandboxMode: true,
                                      //       returnURL: "success.snippetcoder.com",
                                      //       cancelURL: "cancel.snippetcoder.com",
                                      //       transactions:   [
                                      //         {
                                      //           "amount": {
                                      //             "total": double.parse(widget.selectedPackage?['price']),
                                      //             "currency": "USD",
                                      //             "details": {
                                      //               "subtotal": double.parse(widget.selectedPackage?['price']),
                                      //               "shipping": '0',
                                      //               "shipping_discount": 0
                                      //             }
                                      //           },
                                      //           "description":
                                      //           "The payment transaction description.",
                                      //           // "payment_options": {
                                      //           //   "allowed_payment_method":
                                      //           //       "INSTANT_FUNDING_SOURCE"
                                      //           // },
                                      //           "item_list": {
                                      //             "items": [
                                      //               {
                                      //                 "name": widget.selectedPackage?['name'],
                                      //                 "quantity": '1',
                                      //                 "price": widget.selectedPackage?['price'],
                                      //                 "currency": "USD"
                                      //               },
                                      //               // {
                                      //               //   "name": "Pineapple",
                                      //               //   "quantity": 5,
                                      //               //   "price": '10',
                                      //               //   "currency": "USD"
                                      //               // }
                                      //             ],
                                      //
                                      //             // shipping address is not required though
                                      //             // "shipping_address": {
                                      //             //   "recipient_name": "Raman Singh",
                                      //             //   "line1": "Delhi",
                                      //             //   "line2": "",
                                      //             //   "city": "Delhi",
                                      //             //   "country_code": "IN",
                                      //             //   "postal_code": "11001",
                                      //             //   "phone": "+00000000",
                                      //             //   "state": "Texas"
                                      //             // },
                                      //           }
                                      //         }
                                      //       ],
                                      //
                                      //       // client ids
                                      //       //  clientId: 'ATkBD6J5eLYdsDnjmNRJieWhlDyFl_3tk0qlRfUln4_OQ4D4Z-HeHwMblMyb87coB64_Z2V4tFHhDpy7',
                                      //       //  secretKey: 'EF-jLXtL3p4QXHRXHQaDeMJ6Ifex5xn1bzukc5mBzuczOl8ZqKm_qn4kctC32vnLnznXfSCW_ePh9ylA'
                                      //
                                      //       // my ids
                                      //       clientId:
                                      //       'AYA5Xg9t0RnixQN7yyN82YcQD-58pKMbU6j6AlN3sFuuK0n5o9CImA0Dvqx25ZaZ0P0ifLsrR8R2Fgn9',
                                      //       secretKey:
                                      //       'ELvU84r_EZBJHu47e7IEqdJ5IxyAlyx8EtFwtuT9MAinYM2N5Gh_m-WAMD1olGQRqifLCFALnIKNWvMe',
                                      //     ),
                                      //   ),
                                      // );
                                      // return Navigator.of(context).push(
                                      //         MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               const OrderPlacedScreen(),
                                      //         ),
                                      //       );
                                    },
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
      ),
    );
  }
}
