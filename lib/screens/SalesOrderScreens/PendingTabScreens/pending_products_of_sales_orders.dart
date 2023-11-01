import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:Uzaar/widgets/sales_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/product_list_tile.dart';
import '../sales_order_detail.dart';

class PendingProductsOfSalesOrders extends StatefulWidget {
  const PendingProductsOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PendingProductsOfSalesOrders> createState() =>
      _PendingProductsOfSalesOrdersState();
}

class _PendingProductsOfSalesOrdersState
    extends State<PendingProductsOfSalesOrders> {
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SalesOrderDetailScreen(),
              ));
            },
            child: SalesOrdersProductsListTile(
              productImage: 'assets/listed_pro_img.png',
              productName: 'Iphone 14',
              productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
              onSelected: (selectedOffer) {
                setState(() {
                  offerStatus = selectedOffer;
                });
              },
              initialSelection: offerStatus,
              dropdownMenuEntries: offerStatuses
                  .map((String value) =>
                      DropdownMenuEntry(value: value, label: value))
                  .toList(),
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
