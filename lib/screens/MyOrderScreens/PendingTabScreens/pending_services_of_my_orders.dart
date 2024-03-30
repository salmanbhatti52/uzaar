import 'package:uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

import '../my_order_detail.dart';

class PendingServicesOfMyOrders extends StatefulWidget {
  const PendingServicesOfMyOrders({super.key});

  @override
  State<PendingServicesOfMyOrders> createState() =>
      _PendingServicesOfMyOrdersState();
}

class _PendingServicesOfMyOrdersState extends State<PendingServicesOfMyOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyOrderDetailScreen(),
              // ));
            },
            child: const MyOrdersServicesListTile(
              serviceImage: 'assets/listed_service_img.png',
              serviceName: 'Graphic Design ',
              serviceLocation: 'Los Angeles',
              servicePrice: '\$12',
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
