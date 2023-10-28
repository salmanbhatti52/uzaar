import 'package:Uzaar/utils/reusable_data.dart';
import 'package:Uzaar/widgets/service_list_tile.dart';
import 'package:flutter/material.dart';

class ServiceListingScreen extends StatefulWidget {
  const ServiceListingScreen({Key? key}) : super(key: key);

  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
  dynamic selectedOption;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ServiceListTile(
            serviceImage: 'assets/listed_service_img.png',
            serviceName: 'Graphic Design',
            serviceLocation: 'Los Angeles',
            servicePrice: '\$12',
            onSelected: (selectedValue) {
              setState(() {
                selectedOption = selectedValue;
              });
            },
            itemBuilder: (context) {
              return popupMenuOptions;
            },
            initialValue: selectedOption,
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
