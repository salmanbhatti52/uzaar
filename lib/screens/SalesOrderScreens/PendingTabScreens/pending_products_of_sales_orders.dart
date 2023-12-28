import 'package:Uzaar/widgets/sales_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../sales_order_detail.dart';

class PendingProductsOfSalesOrders extends StatefulWidget {
  const PendingProductsOfSalesOrders({super.key});

  @override
  State<PendingProductsOfSalesOrders> createState() =>
      _PendingProductsOfSalesOrdersState();
}

class _PendingProductsOfSalesOrdersState
    extends State<PendingProductsOfSalesOrders> {
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];

  acceptOffer() async {}

  rejectOffer() {}
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SalesOrderDetailScreen(),
              ));
            },
            child: SalesOrdersProductsListTile(
              enabled: true,
              productImage: 'uploads/listings_images/1702018981351262819.jpeg',
              productName: 'Iphone 14',
              // productLocation: 'Los Angeles',
              productPrice: '\$12',
              date: '08/08/2023',
              onSelected: (selectedOffer) async {
                setState(() {
                  offerStatus = selectedOffer;
                });
                if (offerStatus == 'Accept') {}
                if (offerStatus == 'Reject') {}
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
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
