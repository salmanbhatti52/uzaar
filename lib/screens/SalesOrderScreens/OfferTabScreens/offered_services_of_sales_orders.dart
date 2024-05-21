import 'package:uzaar/widgets/sales_orders_services_list_tile.dart';
import 'package:flutter/material.dart';


class OfferedServicesOfSalesOrders extends StatefulWidget {
  const OfferedServicesOfSalesOrders({super.key});

  @override
  State<OfferedServicesOfSalesOrders> createState() =>
      _OfferedServicesOfSalesOrdersState();
}

class _OfferedServicesOfSalesOrdersState
    extends State<OfferedServicesOfSalesOrders> {
  @override
  Widget build(BuildContext context) {
    String offerStatus = 'Pending';
    List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const SalesOrderDetailScreen(),
              // ));
            },
            child: SalesOrdersServicesListTile(
              serviceImage: 'assets/listed_service_img.png',
              serviceName: 'Graphic Design ',
              serviceLocation: 'Los Angeles',
              servicePrice: '\$12',
              date: '08/08/2023',
              // offeredPrice: '\$12',
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
