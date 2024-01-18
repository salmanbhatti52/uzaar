// import 'package:http/http.dart' ;
// import 'dart:async';
// import 'dart:convert' as convert;
// import 'package:http_auth/http_auth.dart';
//
// class PaypalServices {
//
//   String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
// //  String domain = "https://api.paypal.com"; // for production mode
//
//   // change clientId and secret with your own, provided by paypal
//   String clientId = 'AYA5Xg9t0RnixQN7yyN82YcQD-58pKMbU6j6AlN3sFuuK0n5o9CImA0Dvqx25ZaZ0P0ifLsrR8R2Fgn9';
//   String secret = 'ELvU84r_EZBJHu47e7IEqdJ5IxyAlyx8EtFwtuT9MAinYM2N5Gh_m-WAMD1olGQRqifLCFALnIKNWvMe';
//
//   // for getting the access token from Paypal
//   Future<String> getAccessToken() async {
//     try {
//       var client = BasicAuthClient(clientId, secret);
//       Response response = await client.post( Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials')) ;
//       if (response.statusCode == 200) {
//         final body = convert.jsonDecode(response.body);
//         return body["access_token"];
//       }
//       return '';
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // for creating the payment request with Paypal
//   Future<Map<String, String>> createPaypalPayment(
//       transactions, accessToken) async {
//     try {
//       Response response = await post(Uri.parse("$domain/v1/payments/payment"),
//           body: convert.jsonEncode(transactions),
//           headers: {
//             "content-type": "application/json",
//             'Authorization': 'Bearer  $accessToken'
//           });
//
//       final body = convert.jsonDecode(response.body);
//       if (response.statusCode == 201) {
//         if (body["links"] != null && body["links"].length > 0) {
//           List links = body["links"];
//
//           String executeUrl = "";
//           String approvalUrl = "";
//           final item = links.firstWhere((o) => o["rel"] == "approval_url",
//               orElse: () => null);
//           if (item != null) {
//             approvalUrl = item["href"];
//           }
//           final item1 = links.firstWhere((o) => o["rel"] == "execute",
//               orElse: () => null);
//           if (item1 != null) {
//             executeUrl = item1["href"];
//           }
//           return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
//         }
//         return {};
//       } else {
//         throw Exception(body["message"]);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // for executing the payment transaction
//   Future<String> executePayment(url, payerId, accessToken) async {
//     try {
//       Response response = await post(url,
//           body: convert.jsonEncode({"payer_id": payerId}),
//           headers: {
//             "content-type": "application/json",
//             'Authorization': 'Bearer  $accessToken'
//           });
//
//       final body = convert.jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return body["id"];
//       }
//       return '';
//     } catch (e) {
//       rethrow;
//     }
//   }
// }