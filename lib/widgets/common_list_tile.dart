import 'package:uzaar/services/restService.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

final userNameTextStyle = GoogleFonts.outfit(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: black,
);

final durationTextStyle = GoogleFonts.outfit(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  color: grey,
);

class CommonListTile extends StatelessWidget {
  final String imageName;
  final String? notificationImage;
  final String detail;
  final String duration;
  final String title;
  const CommonListTile(
      {super.key, required this.imageName,
      required this.title,
      required this.detail,
      required this.duration,
      this.notificationImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width,
      // height: 80.h,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: grey.withOpacity(0.5),
      //   ),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      decoration: kCardBoxDecoration,
      child: Row(
        children: [
          notificationImage == null
              ? CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: const Color(0xFFD9D9D9),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: imageName.isNotEmpty
                        ? Image.network(
                            imgBaseUrl + imageName,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                )
              : Image.asset(
                  notificationImage!,
                  height: 60,
                  width: 60,
                ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: userNameTextStyle,
                    ),
                    Text(
                      duration,
                      textAlign: TextAlign.center,
                      style: durationTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Text(
                    detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: kTextFieldHintStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonListTileDummy extends StatelessWidget {
  const CommonListTileDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width,
      height: 80,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: grey.withOpacity(0.5),
      //   ),
      //   borderRadius: BorderRadius.circular(10),
      // ),

      decoration: kCardBoxDecoration.copyWith(
        color: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
