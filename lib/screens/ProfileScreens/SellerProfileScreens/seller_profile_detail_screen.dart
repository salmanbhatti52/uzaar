import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/text_form_field_reusable.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';
import 'package:Uzaar/widgets/text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerProfileDetailScreen extends StatefulWidget {
  const SellerProfileDetailScreen({super.key});

  @override
  State<SellerProfileDetailScreen> createState() =>
      _SellerProfileDetailScreenState();
}

class _SellerProfileDetailScreenState extends State<SellerProfileDetailScreen> {
  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 20),
          child: Column(
            children: [
              ProfileInfoTile(
                  imageName: 'email-icon.svg',
                  title: 'Email',
                  description: 'lisafernandes@gamil.com'),
              ProfileInfoTile(
                  imageName: 'phone-fill.svg',
                  title: 'Contact Number',
                  description: '+1656565565'),
              ProfileInfoTile(
                  imageName: 'address-icon.svg',
                  title: 'Address',
                  description: 'Los Angelus')
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile(
      {super.key,
      required this.imageName,
      required this.title,
      required this.description});
  final String imageName;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: f5f5f5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/$imageName'),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kSimpleTextStyle,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                description,
                style: kFontSixteenSixHB,
              )
            ],
          )
        ],
      ),
    );
  }
}
