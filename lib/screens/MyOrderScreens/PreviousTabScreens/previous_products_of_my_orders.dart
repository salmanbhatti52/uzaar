import 'package:Uzaar/widgets/add_review_dialog.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:Uzaar/widgets/get_stars_tile.dart';
import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/message_text_field.dart';
import '../../../widgets/product_list_tile.dart';
import '../my_order_detail.dart';

class PreviousProductsOfMyOrders extends StatefulWidget {
  const PreviousProductsOfMyOrders({Key? key}) : super(key: key);

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
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyOrderDetailScreen(),
              // ));
            },
            child: MyOrdersProductsListTile(
              productImage: 'assets/listed_pro_img.png',
              productName: 'Iphone 14',
              productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
              offeredPrice: '\$12',
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
