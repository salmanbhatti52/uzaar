import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/text.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
