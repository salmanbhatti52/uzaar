import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/mini_dropdown_menu.dart';
import 'package:Uzaar/widgets/review_tile_widget.dart';

import 'package:flutter/material.dart';

class ProfileReviewsScreen extends StatefulWidget {
  const ProfileReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileReviewsScreen> createState() => _ProfileReviewsScreenState();
}

class _ProfileReviewsScreenState extends State<ProfileReviewsScreen> {
  final List<String> reviewTypes = ['Added By You', 'Added By Others'];
  late String selectedType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topRight,
          child: RoundedMiniDropdownMenu(
              width: 163,
              onSelected: (value) {
                setState(() {
                  selectedType = value;
                });
              },
              dropdownMenuEntries: reviewTypes
                  .map(
                    (String value) =>
                        DropdownMenuEntry<String>(value: value, label: value),
                  )
                  .toList(),
              hintText: 'Added By You',
              leadingIconName: null),
        ),
        SizedBox(
          height: 15,
        ),
        //height for sized box
        // height: MediaQuery.sizeOf(context).height * 0.33,
        GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: primaryBlue,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 15),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 6,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ReviewListTile(
                imageName: 'assets/chat_image.png',
                title: 'John Doe',
                detail: 'Lorem ipsum dolor sit amet consectetur.',
                date: '08/08/2023',
              );
            },
          ),
        )
      ],
    );
  }
}
