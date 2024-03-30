import 'package:uzaar/widgets/sales_orders_housings_list_tile.dart';
import 'package:flutter/material.dart';

import '../sales_order_detail.dart';

class PendingHousingsOfSalesOrders extends StatefulWidget {
  const PendingHousingsOfSalesOrders({super.key});

  @override
  State<PendingHousingsOfSalesOrders> createState() =>
      _PendingHousingsOfSalesOrdersState();
}

class _PendingHousingsOfSalesOrdersState
    extends State<PendingHousingsOfSalesOrders> {
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const SalesOrderDetailScreen(),
              // ));
            },
            child: SalesOrdersHousingsListTile(
              houseImage: 'assets/listed_house_img.png',
              houseName: '2 bedroom house ',
              houseLocation: 'Los Angeles',
              housePrice: '\$1200',
              houseArea: '4500',
              houseType: 'Rental',
              noOfBaths: '2',
              noOfBeds: '2',
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
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
