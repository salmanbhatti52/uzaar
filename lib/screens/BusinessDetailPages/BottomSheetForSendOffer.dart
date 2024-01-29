import 'dart:convert';

import 'package:uzaar/services/restService.dart';
import 'package:uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/utils/Buttons.dart';
import 'package:http/http.dart';

import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';

class BottomSheetForSendOffer extends StatefulWidget {
  const BottomSheetForSendOffer({
    super.key,
    required this.listingData,
  });
  final dynamic listingData;
  // final BuildContext buildContext;
  @override
  State<BottomSheetForSendOffer> createState() =>
      _BottomSheetForSendOfferState();
}

class _BottomSheetForSendOfferState extends State<BottomSheetForSendOffer> {
  final TextEditingController priceEditingController = TextEditingController();
  bool setLoader = false;
  String setButtonStatus = 'Send';
  dynamic sentOfferResponse;
  String errorMessage = '';

  Future<String> sendOffer() async {
    Response response =
        await sendPostRequest(action: 'send_offer_listings_products', data: {
      'listings_products_id': widget.listingData['listings_products_id'],
      'users_customers_id': userDataGV['userId'],
      'offer_price': priceEditingController.text.toString()
    });
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      sentOfferResponse = decodedData['data'];
      return status;
    }
    if (status == 'error') {
      errorMessage = decodedData['message'];
      return status;
    }
    return '';
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Offer',
              textAlign: TextAlign.center,
              style: kBodyHeadingTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: ReusableText(text: 'Enter Offer Price'),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 46,
              child: TextFormFieldWidget(
                focusedBorder: kRoundedActiveBorderStyle,
                controller: priceEditingController,
                textInputType: TextInputType.number,
                prefixIcon: const SvgIcon(imageName: 'assets/service_icon.svg'),
                hintText: 'Please enter appropriate offer price',
                // 'Please enter appropriate offer price',
                    // 'Amount not less than \$${widget.listingData['min_offer_price']} ',
                obscureText: null,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      onTap: () async {
                        print('entered');
                        if (priceEditingController.text.isEmpty) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(ErrorSnackBar(
                            message: 'Please enter your offer price',
                          ));
                        } else if (double.parse(priceEditingController.text) <
                            double.parse(
                                widget.listingData['min_offer_price'])) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
                              message: 'Plz increase your offer'
                                  // 'Amount not less than \$${widget.listingData['min_offer_price']}'
                              ));
                        } else {
                          setState(() {
                            setLoader = true;
                            setButtonStatus = 'Please wait..';
                          });
                          String status = await sendOffer();
                          setState(() {
                            setLoader = false;
                            setButtonStatus = 'Send';
                          });
                          if (status == 'success') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SuccessSnackBar(message: 'Offer sent'));
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(message: errorMessage));
                          }
                        }
                      },
                      showLoader: setLoader)),
            ),
          ],
        ),
      ),
    );
  }
}
