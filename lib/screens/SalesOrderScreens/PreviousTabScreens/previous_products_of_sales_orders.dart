import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:Uzaar/widgets/sales_orders_products_list_tile.dart';
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
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          // here is use myOrderProductListTile instead of SalesOrderProductListTile because the design is same as MyOrdersProductListTile.
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
