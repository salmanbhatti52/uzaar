import 'package:Uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

class PreviousServicesOfMyOrders extends StatefulWidget {
  const PreviousServicesOfMyOrders({Key? key}) : super(key: key);

  @override
  State<PreviousServicesOfMyOrders> createState() =>
      _PreviousServicesOfMyOrdersState();
}

class _PreviousServicesOfMyOrdersState
    extends State<PreviousServicesOfMyOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MyOrdersServicesListTile(
            serviceImage: 'assets/listed_service_img.png',
            serviceName: 'Graphic Design ',
            serviceLocation: 'Los Angeles',
            servicePrice: '\$12',
            date: '08/08/2023',
            offeredPrice: '\$12',
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
