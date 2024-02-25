import 'package:uzaar/utils/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/icon_text_combo.dart';

List<PopupMenuEntry> popupMenuOptions = [
  PopupMenuItem(
    value: 'boost',
    child: IconTextReusable(
      mainAxisAlignment: MainAxisAlignment.start,
      imageName: 'boost_option',
      text: 'Boost Listing',
      style: kBodyTextStyle,
      spaceBetween: 10,
      height: 20,
      width: 20,
    ),
  ),
  PopupMenuItem(
    value: 'edit',
    child: IconTextReusable(
      mainAxisAlignment: MainAxisAlignment.start,
      imageName: 'edit_option',
      text: 'Edit',
      spaceBetween: 10,
      height: 20,
      width: 20,
      style: kBodyTextStyle,
    ),
  ),
  PopupMenuItem(
    value: 'delete',
    child: IconTextReusable(
      mainAxisAlignment: MainAxisAlignment.start,
      imageName: 'delete_option',
      spaceBetween: 10,
      height: 20,
      width: 20,
      text: 'Delete',
      style: kBodyTextStyle,
    ),
  ),
];
