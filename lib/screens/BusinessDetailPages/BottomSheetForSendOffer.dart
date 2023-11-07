import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/utils/Buttons.dart';

import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';

class BottomSheetForSendOffer extends StatelessWidget {
  BottomSheetForSendOffer({super.key});
  TextEditingController nameEditingController = TextEditingController();
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
                controller: nameEditingController,
                textInputType: TextInputType.text,
                prefixIcon: SvgIcon(imageName: 'assets/service_icon.svg'),
                hintText: 'Amount not less than \$20 ',
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
                      buttonText: 'Send',
                      onTap: () => Navigator.pop(context),
                      showLoader: false)),
            ),
          ],
        ),
      ),
    );
  }
}
