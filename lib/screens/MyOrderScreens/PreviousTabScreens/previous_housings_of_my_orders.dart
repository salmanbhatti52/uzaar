import 'package:Uzaar/widgets/my_orders_housings_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/add_review_dialog.dart';
import '../../../widgets/get_stars_tile.dart';
import '../../../widgets/message_text_field.dart';
import '../my_order_detail.dart';

class PreviousHousingsOfMyOrders extends StatefulWidget {
  const PreviousHousingsOfMyOrders({Key? key}) : super(key: key);

  @override
  State<PreviousHousingsOfMyOrders> createState() =>
      _PreviousHousingsOfMyOrdersState();
}

class _PreviousHousingsOfMyOrdersState
    extends State<PreviousHousingsOfMyOrders> {
  final msgTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyOrderDetailScreen(),
              // ));
              showDialog(
                context: context,
                builder: (context) {
                  return AddReviewDialog(
                    content: StarsTile(
                        noOfStars: 5, alignment: MainAxisAlignment.center),
                    title: Image.asset('assets/order_complete.png'),
                    textField: MessageTextField(
                      msgTextFieldController: msgTextFieldController,
                      sendButtonTap: () {},
                    ),
                  );
                },
              );
            },
            child: MyOrdersHousingsListTile(
              houseImage: 'assets/listed_house_img.png',
              houseName: '2 bedroom house ',
              houseLocation: 'Los Angeles',
              housePrice: '\$1200',
              houseArea: '4500',
              houseType: 'Rental',
              noOfBaths: '2',
              noOfBeds: '2',
              date: '08/08/2023',
              // offeredPrice: '\$1200',
            ),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
