import 'dart:convert';

import 'package:http/http.dart';
import 'package:uzaar/services/restService.dart';
import 'package:uzaar/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzaar/widgets/snackbars.dart';

import '../../utils/Buttons.dart';

import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  bool textareaFocused = false;
  bool setLoader = false;
  String setButtonStatus = 'Send';
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          textareaFocused = false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'assets/back-arrow-button.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          centerTitle: false,
          title: Text(
            'Contact Us',
            style: kAppBarTitleStyle,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const SvgIcon(imageName: 'assets/app_logo.svg'),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'uzaar Market',
                    style: kAppBarTitleStyle,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'info@uzaar.com',
                    style: kSimpleTextStyle,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(text: 'Name'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextFormFieldWidget(
                      focusedBorder: kRoundedActiveBorderStyle,
                      onTap: () {
                        textareaFocused = false;
                      },
                      controller: nameController,
                      textInputType: TextInputType.name,
                      prefixIcon: const SvgIcon(imageName: 'assets/person-icon.svg'),
                      hintText: 'Name',
                      obscureText: null,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(text: 'Email')),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextFormFieldWidget(
                      focusedBorder: kRoundedActiveBorderStyle,
                      onTap: () {
                        textareaFocused = false;
                      },
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: const SvgIcon(imageName: 'assets/email-icon.svg'),
                      hintText: 'username@gmail.com',
                      obscureText: null,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(text: 'Message')),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                    height: 80,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.14),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: textareaFocused
                            ? Border.all(
                                color: primaryBlue,
                                width: 1,
                                style: BorderStyle.solid)
                            : null),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 5, top: 10),
                            child: const SvgIcon(imageName: 'assets/msg_icon.svg')),
                        const SizedBox(
                          width: 0,
                        ),
                        Expanded(
                          child: TextFormField(
                            onSaved: (newValue) {},
                            onTap: () {
                              textareaFocused = true;
                            },
                            minLines: 4,
                            maxLines: 6,
                            keyboardType: TextInputType.multiline,
                            controller: messageController,
                            style: kTextFieldInputStyle,
                            cursorColor: primaryBlue,
                            decoration: InputDecoration(
                                hintText: 'Your Message Here',
                                hintStyle: kTextFieldHintStyle,
                                filled: true,
                                fillColor: white,
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  primaryButton(
                      context: context,
                      buttonText: setButtonStatus,
                      onTap: () async {
                        String emailRegex =
                            r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
                        RegExp regex = RegExp(emailRegex);
                        if(nameController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: 'Please enter your name'));
                        }else if(emailController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: 'Please enter your email',));
                        }else if(!regex.hasMatch(emailController.text.trim())){
                          ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: 'Please enter a valid email',));
                        }else if(messageController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: 'Please enter your message'));
                        }else{
                          setState(() {
                            setButtonStatus = 'Please wait..';
                            setLoader = true;
                          });
                          Response response = await sendPostRequest(action: 'contact_us', data: {
                            'users_customers_id': userDataGV['userId'].toString(),
                            'message': messageController.text.toString()
                          });
                          setState(() {
                            setButtonStatus = 'Send';
                            setLoader = false;
                          });
                          print(response.body);
                          var decodedResponse = jsonDecode(response.body);
                          String status = decodedResponse['status'];
                          if(status == 'success'){
                            ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(message: 'Your message sent successfully'));
                            Navigator.of(context).pop();
                          }else if(status == 'error'){
                            ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(message: 'Something went wrong.'));
                            Navigator.of(context).pop();
                          }else{}
                        }
                      },
                      showLoader: setLoader),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
