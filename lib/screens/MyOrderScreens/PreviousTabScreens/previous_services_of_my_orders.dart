import 'package:Uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/add_review_dialog.dart';
import '../../../widgets/get_stars_tile.dart';
import '../../../widgets/message_text_field.dart';

class PreviousServicesOfMyOrders extends StatefulWidget {
  const PreviousServicesOfMyOrders({Key? key}) : super(key: key);

  @override
  State<PreviousServicesOfMyOrders> createState() =>
      _PreviousServicesOfMyOrdersState();
}

class _PreviousServicesOfMyOrdersState
    extends State<PreviousServicesOfMyOrders> {
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
                      sendButtonTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
            child: MyOrdersServicesListTile(
              serviceImage: 'assets/listed_service_img.png',
              serviceName: 'Graphic Design ',
              serviceLocation: 'Los Angeles',
              servicePrice: '\$12',
              date: '08/08/2023',
              // offeredPrice: '\$12',
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
