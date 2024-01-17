import 'package:uzaar/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/heading_and_detail.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Terms of Use',
          style: kAppBarTitleStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
          child: Column(
            children: [
              HeadingAndDetail(
                  title: 'Data Handling',
                  description:
                      'Lorem ipsum dolor sit amet consectetur. Integer aliquam turpis consectetur molestie. At sit felis luctus amet consequat odio in justo diam. Arcu commodo vitae nullam eget lectus sed. Et habitasse netus malesuada vivamus cum enim eleifend in orci. Consectetur id aliquet orci diam integer volutpat erat semper quis.'),
              SizedBox(
                height: 20,
              ),
              HeadingAndDetail(
                  title: 'System Limitations',
                  description:
                      'Lorem ipsum dolor sit amet consectetur. Integer aliquam turpis consectetur molestie. At sit felis luctus amet consequat odio in justo diam. Arcu commodo vitae nullam eget lectus sed. Et habitasse netus malesuada vivamus cum enim eleifend in orci. Consectetur id aliquet orci diam integer volutpat erat semper quis.'),
              SizedBox(
                height: 20,
              ),
              HeadingAndDetail(
                  title: 'Data Flow',
                  description:
                      'Lorem ipsum dolor sit amet consectetur. Integer aliquam turpis consectetur molestie. At sit felis luctus amet consequat odio in justo diam. Arcu commodo vitae nullam eget lectus sed. Et habitasse netus malesuada vivamus cum enim eleifend in orci. Consectetur id aliquet orci diam integer volutpat erat semper quis.'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
