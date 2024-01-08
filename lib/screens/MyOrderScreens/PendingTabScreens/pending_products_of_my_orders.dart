import 'package:Uzaar/screens/MyOrderScreens/my_order_detail.dart';

import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

class PendingProductsOfMyOrders extends StatefulWidget {
  const PendingProductsOfMyOrders({super.key});

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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyOrderDetailScreen(),
              ));
            },
            child: const MyOrdersProductsListTile(
              productCondition: 'Used',
              productImage: 'uploads/listings_images/17013232441588376617.jpeg',
              productName: 'Iphone 14',
              // productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
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
