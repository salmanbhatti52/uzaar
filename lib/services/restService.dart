import 'package:http/http.dart' as http;
import 'dart:convert';

const apiBaseUrl = 'https://uzaar.eigix.net/api/';
const imgBaseUrl = 'https://uzaar.eigix.net/public/';
dynamic featuredProductsGV;
dynamic featuredServicesGV;
dynamic featuredHousingGV;
dynamic listingTypesGV;
dynamic allListingsProductsGV;
dynamic allListingsServicesGV;
dynamic allListingsHousingsGV;
dynamic productListingCategoriesGV;
dynamic serviceListingCategoriesGV;
dynamic housingListingCategoriesGV;
List<String> productListingCategoriesNames = [];
List<String> serviceListingCategoriesNames = [];
List<String> housingListingCategoriesNames = [];
List<String> productsPriceRangesGV = [];
List<String> servicesPriceRangesGV = [];
List<String> housingsPriceRangesGV = [];
Map<String, dynamic> userDataGV = {}; //GV : GlobalVariable
Map<String, dynamic> guestUserDataGV = {}; //GV : GlobalVariable
bool loginAsGuestGV = false; //GV : GlobalVariable

Future<http.Response> sendGetRequest(String action) {
  return http.get(Uri.parse(apiBaseUrl + action));
}

Future<http.Response> sendPostRequest(
    {required String action, required Map<String, dynamic>? data}) {
  print('action: $action');
  print('Map Payloads: $data');

  return http.post(
    Uri.parse(
      apiBaseUrl + action,
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
