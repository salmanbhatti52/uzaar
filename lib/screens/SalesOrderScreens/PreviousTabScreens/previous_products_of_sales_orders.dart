import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/product_list_tile.dart';

class PreviousProductsOfSalesOrders extends StatefulWidget {
  const PreviousProductsOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PreviousProductsOfSalesOrders> createState() =>
      _PreviousProductsOfSalesOrdersState();
}

class _PreviousProductsOfSalesOrdersState
    extends State<PreviousProductsOfSalesOrders> {
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
            offeredPrice: '\$12',
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
