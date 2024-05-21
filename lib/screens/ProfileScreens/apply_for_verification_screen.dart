import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzaar/services/restService.dart';
import 'package:uzaar/utils/Buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzaar/widgets/snackbars.dart';

import '../../services/getImage.dart';
import '../../utils/Colors.dart';

class ApplyForVerificationScreen extends StatefulWidget {
  const ApplyForVerificationScreen({super.key});

  @override
  State<ApplyForVerificationScreen> createState() =>
      _ApplyForVerificationScreenState();
}

class _ApplyForVerificationScreenState
    extends State<ApplyForVerificationScreen> {
  String selectedImageInBase64 = '';
  Map<String, dynamic> images = {};
  bool setLoader = false;
  String setButtonStatus = 'Submit';
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    preferences = await SharedPreferences.getInstance();
  }

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
      body: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
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
                  child: GestureDetector(
                    onTap: () async {
                      images = await getImage(from: 'gallery');

                      selectedImageInBase64 = images['image']['imageInBase64'];
                      setState(() {});
                    },
                    child: SvgPicture.asset(
                      'assets/upload-pic.svg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              images.isNotEmpty
                  ? SizedBox(
                      height: 240,
                      width: MediaQuery.sizeOf(context).width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(images['image']['imageInXFile'].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                    ),
              // const Spacer(),

              Container(
                  padding: const EdgeInsets.only(top: 25),
                  // margin: const EdgeInsets.only(bottom: 25),
                  child: primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      onTap: () async {
                        if (selectedImageInBase64.isNotEmpty) {
                          setState(() {
                            setLoader = true;
                            setButtonStatus = 'Please wait..';
                          });
                          Response response = await sendPostRequest(
                              action: 'apply_for_verification',
                              data: {
                                'users_customers_id': userDataGV['userId'],
                                'document': selectedImageInBase64,
                              });
                          setState(() {
                            setLoader = false;
                            setButtonStatus = 'Submit';
                          });
                          print(response.statusCode);
                          print(response.body);
                          var decodedData = jsonDecode(response.body);
                          String status = decodedData['status'];
                          String message = decodedData['message'];
                          if (status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SuccessSnackBar(message: message));
                            profileVerificationStatusGV = 'Pending';
                          } else if (status == 'error') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(ErrorSnackBar(message: message));
                            profileVerificationStatusGV = 'Pending';
                          } else {}
                          Navigator.of(context)
                              .pop(profileVerificationStatusGV);
                          // Navigator.of(context).pop();
                        } else if (selectedImageInBase64.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              ErrorSnackBar(message: 'Plz upload your Id'));
                        } else {}
                      },
                      showLoader: setLoader))
            ],
          ),
        ),
      ),
    );
  }
}
