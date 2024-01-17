import 'package:flutter/material.dart';
import 'package:uzaar/widgets/suffix_svg_icon.dart';

import '../utils/Colors.dart';
import 'text_form_field_reusable.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
    this.onChanged,
    // this.onSubmitted
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  // final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormFieldWidget(
        onChanged: onChanged,
        // onSubmitted: onSubmitted,

        focusedBorder: kRoundedActiveBorderStyle,
        controller: searchController,
        textInputType: TextInputType.name,
        prefixIcon: const SvgIcon(imageName: 'assets/search-button.svg'),
        hintText: 'Search Here',
        obscureText: null,
      ),
    );
  }
}
