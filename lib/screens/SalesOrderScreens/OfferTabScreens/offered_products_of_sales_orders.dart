import 'dart:convert';

import 'package:Uzaar/screens/SalesOrderScreens/sales_order_detail.dart';
import 'package:Uzaar/widgets/sales_orders_products_list_tile.dart';
import 'package:Uzaar/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/restService.dart';
import '../../../widgets/my_orders_products_list_tile.dart';

class OfferedProductsOfSalesOrders extends StatefulWidget {
  OfferedProductsOfSalesOrders(
      {super.key,
      required this.salesOrderedProductOffers,
      required this.salesProductOffersErrMsg});
  final List<dynamic> salesOrderedProductOffers;
  String salesProductOffersErrMsg;
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
      child: widget.salesOrderedProductOffers.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SalesOrderDetailScreen(),
                    ));
                  },
                  child: SalesOrdersProductsListTile(
                    enabled: true,
                    productImage: widget.salesOrderedProductOffers[index]
                        ['listings_products']['listings_images'][0]['image'],
                    productName: widget.salesOrderedProductOffers[index]
                        ['listings_products']['name'],
                    // productLocation: 'Los Angeles',
                    productPrice:
                        '\$${widget.salesOrderedProductOffers[index]['listings_products']['price']}',
                    date: widget.salesOrderedProductOffers[index]['date_added'],
                    offeredPrice:
                        '\$${widget.salesOrderedProductOffers[index]['offer_price']}',
                    onSelected: (selectedOption) async {
                      setState(() {
                        offerStatus = selectedOption;
                      });
                      if (offerStatus == 'Accept') {
                        Response response = await sendPostRequest(
                            action: 'accept_sales_listings_orders_offers',
                            data: {
                              'listings_orders_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_orders_id'],
                              'listings_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_id'],
                              'listings_types_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_types_id'],
                              'listings_categories_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_categories_id'],
                              'users_customers_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['users_customers_id']
                            });
                        print(response.statusCode);
                        print(response.body);
                        var decodedData = jsonDecode(response.body);
                        String status = decodedData['status'];
                        if (status == 'success') {
                          setState(() {
                            widget.salesOrderedProductOffers.removeAt(index);
                            widget.salesProductOffersErrMsg =
                                'No listing found';
                            ScaffoldMessenger.of(context).showSnackBar(
                                SuccessSnackBar(message: 'Offer Accepted'));
                          });
                        }
                        if (status == 'error') {
                          String message = decodedData['message'];
                          ScaffoldMessenger.of(context)
                              .showSnackBar(ErrorSnackBar(message: message));
                        }
                      }
                      if (offerStatus == 'Reject') {
                        Response response = await sendPostRequest(
                            action: 'reject_sales_listings_orders_offers',
                            data: {
                              'listings_orders_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_orders_id'],
                              'listings_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_id'],
                              'listings_types_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_types_id'],
                              'listings_categories_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['listings_categories_id'],
                              'users_customers_id':
                                  widget.salesOrderedProductOffers[index]
                                      ['users_customers_id']
                            });
                        print(response.statusCode);
                        print(response.body);
                        var decodedData = jsonDecode(response.body);
                        String status = decodedData['status'];
                        if (status == 'success') {
                          setState(() {
                            widget.salesOrderedProductOffers.removeAt(index);
                            widget.salesProductOffersErrMsg =
                                'No listing found';
                            ScaffoldMessenger.of(context).showSnackBar(
                                SuccessSnackBar(message: 'Offer Rejected'));
                          });
                        }
                        if (status == 'error') {
                          String message = decodedData['message'];
                          ScaffoldMessenger.of(context)
                              .showSnackBar(ErrorSnackBar(message: message));
                        }
                      }
                    },
                    initialSelection: offerStatus,
                    dropdownMenuEntries: offerStatuses
                        .map((String value) =>
                            DropdownMenuEntry(value: value, label: value))
                        .toList(),
                  ),
                );
              },
              itemCount: widget.salesOrderedProductOffers.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            )
          : widget.salesOrderedProductOffers.isEmpty &&
                  widget.salesProductOffersErrMsg == ''
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
              : widget.salesOrderedProductOffers.isEmpty &&
                      widget.salesProductOffersErrMsg != ''
                  ? Center(
                      child: Text(widget.salesProductOffersErrMsg),
                    )
                  : const SizedBox(),
    );
  }
}
