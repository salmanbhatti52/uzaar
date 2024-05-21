import 'package:uzaar/widgets/my_orders_housings_list_tile.dart';
import 'package:flutter/material.dart';


class OfferedHousingsOfMyOrders extends StatefulWidget {
  const OfferedHousingsOfMyOrders({super.key});

  @override
  State<OfferedHousingsOfMyOrders> createState() =>
      _OfferedHousingsOfMyOrdersState();
}

class _OfferedHousingsOfMyOrdersState extends State<OfferedHousingsOfMyOrders> {
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
            child: const MyOrdersHousingsListTile(
              houseImage: 'assets/listed_house_img.png',
              houseName: '2 bedroom house ',
              houseLocation: 'Los Angeles',
              housePrice: '\$1200',
              houseArea: '4500',
              houseType: 'Rental',
              noOfBaths: '2',
              noOfBeds: '2',
              date: '08/08/2023',
              // offeredPrice: '\$1200',
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
