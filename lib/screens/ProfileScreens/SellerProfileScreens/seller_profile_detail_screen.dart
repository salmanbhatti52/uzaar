import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Uzaar/utils/colors.dart';

import '../../../widgets/profile_info_tile.dart';

class SellerProfileDetailScreen extends StatefulWidget {
  SellerProfileDetailScreen({super.key, this.sellerData});
  dynamic sellerData;

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
                  description: widget.sellerData['email'] ?? ''),
              ProfileInfoTile(
                  imageName: 'phone-fill.svg',
                  title: 'Contact Number',
                  description: widget.sellerData['phone'] ?? ''),
              ProfileInfoTile(
                  imageName: 'address-icon.svg',
                  title: 'Address',
                  description: widget.sellerData['address'] ?? '')
            ],
          ),
        ),
      ),
    );
  }
}
