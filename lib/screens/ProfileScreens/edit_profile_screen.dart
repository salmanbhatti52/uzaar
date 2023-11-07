import 'package:Uzaar/utils/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Colors.dart';
import '../../widgets/suffix_svg_icon.dart';
import '../../widgets/text.dart';
import '../../widgets/text_form_field_reusable.dart';
import '../chat_list_screen.dart';
import '../notifications_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

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
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'assets/back-arrow-button.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          // leading: Builder(
          //   builder: (context) {
          //     return Padding(
          //       padding: const EdgeInsets.only(top: 8.0, left: 20),
          //       child: GestureDetector(
          //         onTap: () => Scaffold.of(context).openDrawer(),
          //         child: SvgPicture.asset(
          //           'assets/drawer-button.svg',
          //           fit: BoxFit.scaleDown,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessagesScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/msg-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/notification-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          title: Text(
            'Edit Profile',
            style: kAppBarTitleStyle,
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ReusableText(text: 'First Name'),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 46,
                child: TextFormFieldWidget(
                  controller: firstNameController,
                  textInputType: TextInputType.name,
                  prefixIcon: SvgPicture.asset(
                    'assets/person-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  hintText: 'First Name',
                  obscureText: null,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ReusableText(text: 'Last Name')),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 46,
                child: TextFormFieldWidget(
                  controller: lastNameController,
                  textInputType: TextInputType.name,
                  prefixIcon: SvgPicture.asset(
                    'assets/person-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  hintText: 'Last Name',
                  obscureText: null,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ReusableText(text: 'Email')),
              SizedBox(
                height: 8,
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
                height: 14,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ReusableText(text: 'Phone Number')),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 46,
                child: TextFormFieldWidget(
                  controller: phoneNumberController,
                  textInputType: TextInputType.phone,
                  prefixIcon: SvgIcon(imageName: 'assets/phone-fill.svg'),
                  hintText: '+4156565662',
                  obscureText: null,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ReusableText(text: 'Address')),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 46,
                child: TextFormFieldWidget(
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  prefixIcon: SvgPicture.asset(
                    'assets/address-icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  suffixIcon: SvgPicture.asset(
                    'assets/address-icon.svg',
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
                  ),
                  hintText: 'Address',
                  obscureText: null,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: primaryButton(
                    context: context,
                    buttonText: 'Save Changes',
                    onTap: () => Navigator.of(context).pop(),
                    showLoader: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
