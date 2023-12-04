import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../my_order_detail.dart';

class OfferedProductsOfMyOrders extends StatefulWidget {
  const OfferedProductsOfMyOrders({Key? key}) : super(key: key);

  @override
  State<OfferedProductsOfMyOrders> createState() =>
      _OfferedProductsOfMyOrdersState();
}

class _OfferedProductsOfMyOrdersState extends State<OfferedProductsOfMyOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyOrderDetailScreen(),
              ));
            },
            child: MyOrdersProductsListTile(
              productImage: 'assets/listed_pro_img.png',
              productName: 'Iphone 14',
              productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
              offeredPrice: '\$12',
              allowPay: true,
              offerStatus: 'Accepted',
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
