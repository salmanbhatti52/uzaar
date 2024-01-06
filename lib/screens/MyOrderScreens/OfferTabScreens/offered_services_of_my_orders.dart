import 'package:Uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

import '../my_order_detail.dart';

class OfferedServicesOfMyOrders extends StatefulWidget {
  const OfferedServicesOfMyOrders({super.key});

  @override
  State<OfferedServicesOfMyOrders> createState() =>
      _OfferedServicesOfMyOrdersState();
}

class _OfferedServicesOfMyOrdersState extends State<OfferedServicesOfMyOrders> {
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
            child: const MyOrdersServicesListTile(
              serviceImage: 'assets/listed_service_img.png',
              serviceName: 'Graphic Design ',
              serviceLocation: 'Los Angeles',
              servicePrice: '\$12',
              date: '08/08/2023',
              // offeredPrice: '\$12',
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
