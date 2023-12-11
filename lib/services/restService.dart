import 'package:http/http.dart' as http;
import 'dart:convert';

const apiBaseUrl = 'https://uzaar.eigix.net/api/';
const imgBaseUrl = 'https://uzaar.eigix.net/public/';

//GV : GlobalVariable
List<dynamic> featuredProductsGV = [];
List<dynamic> featuredServicesGV = [];
List<dynamic> featuredHousingGV = [];
dynamic listingTypesGV;
dynamic allListingsProductsGV;
dynamic allListingsServicesGV;
dynamic allListingsHousingsGV;
dynamic productListingCategoriesGV;
dynamic serviceListingCategoriesGV;
dynamic housingListingCategoriesGV;
List<String> productListingCategoriesNamesGV = [];
List<String> serviceListingCategoriesNamesGV = [];
List<String> housingListingCategoriesNamesGV = [];
List<String> productsPriceRangesGV = [];
List<String> servicesPriceRangesGV = [];
List<String> housingsPriceRangesGV = [];
Map<String, dynamic> userDataGV = {};
Map<String, dynamic> guestUserDataGV = {};
bool loginAsGuestGV = false;
String selectedListingTypeGV = 'Products';
String listingSelectedCategoryGV = '';

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
