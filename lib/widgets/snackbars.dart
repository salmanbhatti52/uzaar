import 'package:flutter/material.dart';

import '../utils/Colors.dart';

SnackBar SuccessSnackBar({String? message}) {
  return SnackBar(
    content: Text(
      message ?? 'Success',
      style: kToastTextStyle,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: primaryBlue,
  );
}

SnackBar ErrorSnackBar({String? message}) {
  return SnackBar(
    content: Text(
      message ?? 'API Error',
      style: kToastTextStyle,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.red,
  );
}

SnackBar AlertSnackBar({String? message}) {
  return SnackBar(
    content: Text(
      message ?? 'API Error',
      style: kToastTextStyle,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.green,
  );
}
