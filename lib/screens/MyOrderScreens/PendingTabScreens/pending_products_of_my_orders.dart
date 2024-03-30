import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uzaar/screens/MyOrderScreens/my_order_detail.dart';

import 'package:uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../services/restService.dart';

class PendingProductsOfMyOrders extends StatefulWidget {
  const PendingProductsOfMyOrders({super.key});

  @override
  State<PendingProductsOfMyOrders> createState() =>
      _PendingProductsOfMyOrdersState();
}

class _PendingProductsOfMyOrdersState extends State<PendingProductsOfMyOrders> {
  bool showSpinner = false;
  String orderedProductsDispatchedErrMsg = '';
  List<dynamic> myOrderedProductsDispatched = [];

  getMyProductsOrdersDispatched() async {
    Response response = await sendPostRequest(
        action: 'get_listings_orders_dispatched',
        data: {'users_customers_id': userDataGV['userId']});
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      if (mounted) {
        setState(() {
          myOrderedProductsDispatched = decodedData['data'];
          for (dynamic order in myOrderedProductsDispatched) {
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
          orderedProductsDispatchedErrMsg = decodedData['message'];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProductsOrdersDispatched();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: myOrderedProductsDispatched.isNotEmpty
          ? ModalProgressHUD(
              inAsyncCall: showSpinner,
              dismissible: true,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyOrderDetailScreen(
                          orderData: myOrderedProductsDispatched[index],
                        ),
                      ));
                    },
                    child:  MyOrdersProductsListTile(
                      productCondition: myOrderedProductsDispatched[index]['listings_products']['condition'],
                      productImage:
                      myOrderedProductsDispatched[index]['listings_products']['listings_images'][0]['image'],
                      productName: myOrderedProductsDispatched[index]['listings_products']['name'],
                      // productLocation: 'Los Angeles',
                      productPrice: '\$${myOrderedProductsDispatched[index]['listings_products']['price']}',
                      date: myOrderedProductsDispatched[index]['date_modified'],
                      offerStatus: myOrderedProductsDispatched[index]
                      ['status'],
                    ),
                  );
                },
                itemCount: myOrderedProductsDispatched.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
              ),
            )
          : myOrderedProductsDispatched.isEmpty &&
                  orderedProductsDispatchedErrMsg == ''
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
              : myOrderedProductsDispatched.isEmpty &&
                      orderedProductsDispatchedErrMsg != ''
                  ? Center(
                      child: Text(orderedProductsDispatchedErrMsg),
                    )
                  : const SizedBox(),
    );
  }
}
