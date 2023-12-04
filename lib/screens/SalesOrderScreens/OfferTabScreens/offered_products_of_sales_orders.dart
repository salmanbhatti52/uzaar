import 'package:Uzaar/screens/SalesOrderScreens/sales_order_detail.dart';
import 'package:Uzaar/widgets/sales_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

class OfferedProductsOfSalesOrders extends StatefulWidget {
  const OfferedProductsOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<OfferedProductsOfSalesOrders> createState() =>
      _OfferedProductsOfSalesOrdersState();
}

class _OfferedProductsOfSalesOrdersState
    extends State<OfferedProductsOfSalesOrders> {
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
              offeredPrice: '\$12',
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
