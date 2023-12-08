import 'dart:convert';

import 'package:Uzaar/services/restService.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';
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
        await sendPostRequest(action: 'send_offer_listings', data: {
      'listings_id': widget.listingData['listings_products_id'],
      'listings_types_id': widget.listingData['listings_types_id'],
      'listings_categories_id': widget.listingData['listings_categories_id'],
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
        decoration: BoxDecoration(
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
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ReusableText(text: 'Enter Offer Price'),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 46,
              child: TextFormFieldWidget(
                focusedBorder: kRoundedActiveBorderStyle,
                controller: priceEditingController,
                textInputType: TextInputType.number,
                prefixIcon: SvgIcon(imageName: 'assets/service_icon.svg'),
                hintText:
                    'Amount not less than \$${widget.listingData['min_offer_price']} ',
                obscureText: null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
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
                              message:
                                  'Amount not less than \$${widget.listingData['min_offer_price']}'));
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
