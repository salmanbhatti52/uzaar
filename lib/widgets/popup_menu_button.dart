import 'package:flutter/material.dart';

class PopupMenuButtonReusable extends StatelessWidget {
  const PopupMenuButtonReusable(
      {super.key, required this.itemBuilder, required this.onSelected, this.initialValue});
  final void Function(dynamic)? onSelected;
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  final dynamic initialValue;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        splashRadius: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(
          Icons.more_vert,
          color: Color(0xff450E8B),
        ),
        iconSize: 24,
        initialValue: initialValue,
// Callback that sets the selected popup menu item.
        onSelected: onSelected,
        itemBuilder: itemBuilder);
  }
}
