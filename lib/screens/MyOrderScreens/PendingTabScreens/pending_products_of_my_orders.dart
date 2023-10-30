import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/product_list_tile.dart';

class PendingProductsOfMyOrders extends StatefulWidget {
  const PendingProductsOfMyOrders({Key? key}) : super(key: key);

  @override
  State<PendingProductsOfMyOrders> createState() =>
      _PendingProductsOfMyOrdersState();
}

class _PendingProductsOfMyOrdersState extends State<PendingProductsOfMyOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MyOrdersProductsListTile(
            productImage: 'assets/listed_pro_img.png',
            productName: 'Iphone 14',
            productLocation: 'Los Angeles',
            productPrice: '\$12',
            date: '08/08/2023',
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
