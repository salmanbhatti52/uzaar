import 'package:Uzaar/widgets/add_review_dialog.dart';
import 'package:Uzaar/widgets/get_stars_tile.dart';
import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/message_text_field.dart';

class PreviousProductsOfMyOrders extends StatefulWidget {
  const PreviousProductsOfMyOrders({super.key});

  @override
  State<PreviousProductsOfMyOrders> createState() =>
      _PreviousProductsOfMyOrdersState();
}

class _PreviousProductsOfMyOrdersState
    extends State<PreviousProductsOfMyOrders> {
  final msgTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddReviewDialog(
                    content: const StarsTile(
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
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyOrderDetailScreen(),
              // ));
            },
            child: const MyOrdersProductsListTile(
              productImage: 'uploads/listings_images/17013232441588376617.jpeg',
              productName: 'Iphone 14',
              // productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
              offeredPrice: '\$12',
            ),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
