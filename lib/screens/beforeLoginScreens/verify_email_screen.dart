import 'package:flutter/material.dart';
import 'package:sellpad/utils/Colors.dart';
import 'package:sellpad/widgets/navigate_back_icon.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: NavigateBack(),
        title: Text(
          'Verify Email',
          style: kAppBarTitleStyle,
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'We have send a verification code to your email',
          ),
          Text('“ username@gmail.com”'),
          Text('Enter code below to verify.'),
        ],
      )),
    );
  }
}
