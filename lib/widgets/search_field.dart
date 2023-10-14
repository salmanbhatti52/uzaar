import 'package:flutter/material.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';

import 'TextfromFieldWidget.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: searchController,
      textInputType: TextInputType.name,
      prefixIcon: SvgIcon(imageName: 'assets/search-button.svg'),
      hintText: 'Search Here',
      obscureText: null,
    );
  }
}
