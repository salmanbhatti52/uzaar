import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../services/restService.dart';
import '../../../widgets/my_orders_products_list_tile.dart';
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
  bool showSpinner = false;
  String salesOrdersDispatchedErrMsg = '';
  List<dynamic> mySalesOrdersDispatched = [];

  getMySalesOrdersDispatched() async {
    Response response = await sendPostRequest(
        action: 'get_sales_listings_orders_dispatched',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          mySalesOrdersDispatched = decodedData['data'];
          for (dynamic order in mySalesOrdersDispatched) {
            DateTime dateTime = DateTime.parse(order['date_added']);
            order['date_added'] = DateFormat('dd/MM/yyyy').format(dateTime);
            if (order['status'] != 'Pending') {
              DateTime dateTime = DateTime.parse(order['date_modified']);
              order['date_modified'] =
                  DateFormat('dd/MM/yyyy').format(dateTime);
            }
          }
        });
      }
    }
    if (status == 'error') {
      if (mounted) {
        setState(() {
          salesOrdersDispatchedErrMsg = decodedData['message'];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySalesOrdersDispatched();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: mySalesOrdersDispatched.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SalesOrderDetailScreen(
                        orderData: mySalesOrdersDispatched[index],
                      ),
                    ));
                  },
                  child: MyOrdersProductsListTile(
                    // productCondition: mySalesOrdersDispatched[index]
                    //     ['listings_products']['condition'],
                    productImage: mySalesOrdersDispatched[index]
                        ['listings_products']['listings_images'][0]['image'],
                    productName: mySalesOrdersDispatched[index]
                        ['listings_products']['name'],
                    // productLocation: 'Los Angeles',
                    productPrice:
                        '\$${mySalesOrdersDispatched[index]['listings_products']['price']}',
                    date: mySalesOrdersDispatched[index]['date_modified'],
                    offerStatus: mySalesOrdersDispatched[index]['status'],
                  ),
                );
              },
              itemCount: mySalesOrdersDispatched.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            )
          : mySalesOrdersDispatched.isEmpty && salesOrdersDispatchedErrMsg == ''
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                                // margin: EdgeInsets.only(bottom: 15),
                                child: const MyOrdersProductsListTileDummy()),
                          ],
                        ));
                  },
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                )
              : mySalesOrdersDispatched.isEmpty &&
                      salesOrdersDispatchedErrMsg != ''
                  ? Center(
                      child: Text(salesOrdersDispatchedErrMsg),
                    )
                  : const SizedBox(),
    );
  }
}

// SalesOrdersProductsListTile(
// enabled: true,
// productImage: 'uploads/listings_images/1702018981351262819.jpeg',
// productName: 'Iphone 14',
// // productLocation: 'Los Angeles',
// productPrice: '\$12',
// date: '08/08/2023',
// onSelected: (selectedOffer) async {
// setState(() {
// offerStatus = selectedOffer;
// });
// if (offerStatus == 'Accept') {}
// if (offerStatus == 'Reject') {}
// },
// initialSelection: offerStatus,
// dropdownMenuEntries: offerStatuses
//     .map((String value) =>
// DropdownMenuEntry(value: value, label: value))
//     .toList(),
// )
