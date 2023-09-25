import 'package:flutter/material.dart';

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
        leading: Icon(Icons.arrow_back),
        title: Text('Verify Email'),
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
