import 'dart:convert';

import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shimmer/shimmer.dart';

import '../../../services/restService.dart';
import '../../../widgets/snackbars.dart';
import '../../chat_screen.dart';
import '../my_order_detail.dart';

class OfferedProductsOfMyOrders extends StatefulWidget {
  const OfferedProductsOfMyOrders(
      {super.key,
      required this.myOrderedProductOffers,
      required this.orderedProductOffersErrMsg});
  final List<dynamic> myOrderedProductOffers;
  final String orderedProductOffersErrMsg;
  @override
  State<OfferedProductsOfMyOrders> createState() =>
      _OfferedProductsOfMyOrdersState();
}

class _OfferedProductsOfMyOrdersState extends State<OfferedProductsOfMyOrders> {
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> startChat({required int otherUserId}) async {
    // if (userDataGV['userId'] == widget.sellerData['users_customers_id']) {
    //   return 'yourself';
    // }
    setState(() {
      showSpinner = true;
    });
    Response response = await sendPostRequest(action: 'user_chat', data: {
      'requestType': 'startChat',
      'users_customers_id': userDataGV['userId'],
      'other_users_customers_id': otherUserId
    });
    setState(() {
      showSpinner = false;
    });
    print(response.statusCode);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'error' || status == 'success') {
      return decodedData['message'];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    navigateToChatScreen(
        {required String otherUserName,
        required int otherUserId,
        required String value}) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ChatScreen(
            otherUserName: otherUserName,
            otherUserId: otherUserId,
            typeOfChat: value,
          );
        },
      ));
    }

    showErrorMessage() {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: 'Something went wrong'));
    }

    return Expanded(
      child: widget.myOrderedProductOffers.isNotEmpty
          ? ModalProgressHUD(
              inAsyncCall: showSpinner,
              dismissible: true,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyOrderDetailScreen(),
                      ));
                    },
                    child: MyOrdersProductsListTile(
                      productImage: widget.myOrderedProductOffers[index]
                          ['listings_products']['listings_images'][0]['image'],
                      productName: widget.myOrderedProductOffers[index]
                          ['listings_products']['name'],
                      // productLocation: 'Los Angeles',
                      productPrice:
                          '\$${widget.myOrderedProductOffers[index]['listings_products']['price']}',
                      date: widget.myOrderedProductOffers[index]['status'] ==
                              'Pending'
                          ? widget.myOrderedProductOffers[index]['date_added']
                          : widget.myOrderedProductOffers[index]
                              ['date_modified'],
                      productCondition: widget.myOrderedProductOffers[index]
                          ['listings_products']['condition'],
                      offeredPrice:
                          '\$${widget.myOrderedProductOffers[index]['offer_price']}',
                      allowPay: widget.myOrderedProductOffers[index]
                                  ['status'] ==
                              'Accepted'
                          ? true
                          : false,
                      offerStatus: widget.myOrderedProductOffers[index]
                          ['status'],
                      onTapArrange: (value) async {
                        print(value);
                        int otherUserId = widget.myOrderedProductOffers[index]
                                ['listings_products']['users_customers']
                            ['users_customers_id'];
                        String message =
                            await startChat(otherUserId: otherUserId);
                        print('Message: $message');
                        if (message.isNotEmpty) {
                          String otherUserFirstName =
                              widget.myOrderedProductOffers[index]
                                      ['listings_products']['users_customers']
                                  ['first_name'];
                          String otherUserLastName =
                              widget.myOrderedProductOffers[index]
                                      ['listings_products']['users_customers']
                                  ['last_name'];
                          navigateToChatScreen(
                              otherUserId: otherUserId,
                              otherUserName:
                                  '$otherUserFirstName $otherUserLastName',
                              value: value);
                        } else {
                          showErrorMessage();
                        }
                        return value;
                      },
                    ),
                  );
                },
                itemCount: widget.myOrderedProductOffers.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
              ),
            )
          : widget.myOrderedProductOffers.isEmpty &&
                  widget.orderedProductOffersErrMsg == ''
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
              : widget.myOrderedProductOffers.isEmpty &&
                      widget.orderedProductOffersErrMsg != ''
                  ? Center(
                      child: Text(widget.orderedProductOffersErrMsg),
                    )
                  : const SizedBox(),
    );
  }
}
