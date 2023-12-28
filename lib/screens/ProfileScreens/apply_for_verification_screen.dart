import 'package:Uzaar/utils/Buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Colors.dart';

class ApplyForVerificationScreen extends StatefulWidget {
  const ApplyForVerificationScreen({super.key});

  @override
  State<ApplyForVerificationScreen> createState() =>
      _ApplyForVerificationScreenState();
}

class _ApplyForVerificationScreenState
    extends State<ApplyForVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Apply for Verification',
          style: kAppBarTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Upload proof of identification to verify your account',
                style: kTextFieldInputStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Upload File Here',
                style: kBodyTextStyle,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 165,
              width: double.infinity,
              decoration: kUploadImageBoxBorderShadow,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SvgPicture.asset(
                  'assets/upload-pic.svg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: primaryButton(
                    context: context,
                    buttonText: 'Submit',
                    onTap: () => Navigator.of(context).pop(),
                    showLoader: false))
          ],
        ),
      ),
    );
  }
}
