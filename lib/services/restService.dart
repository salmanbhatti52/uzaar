import 'package:http/http.dart' as http;
import 'dart:convert';

// const apiBaseUrl = 'https://uzaar.eigix.net/api/';
// const imgBaseUrl = 'https://uzaar.eigix.net/public/';

const apiBaseUrl = 'https://b1gpraiseel.net/portal/api/';
const imgBaseUrl = 'https://b1gpraiseel.net/portal/public/';

//GV : GlobalVariable
List<dynamic> featuredProductsGV = [];
List<dynamic> featuredServicesGV = [];
List<dynamic> featuredHousingGV = [];

// List<dynamic> userFeaturedProductsGV = [];
// List<dynamic> userFeaturedServicesGV = [];
// List<dynamic> userFeaturedHousingGV = [];
List<dynamic> listingTypesGV = [];
List<dynamic> allListingsProductsGV = [];
List<dynamic> allListingsServicesGV = [];
List<dynamic> allListingsHousingsGV = [];
List<dynamic> productListingCategoriesGV = [];
List<dynamic> serviceListingCategoriesGV = [];
List<dynamic> housingListingCategoriesGV = [];
List<dynamic> productsPriceRangesGV = [];
List<dynamic> servicesPriceRangesGV = [];
List<dynamic> housingsPriceRangesGV = [];
List<dynamic> boostingPackagesGV = [];
Map<String, dynamic> userDataGV = {};
Map<String, dynamic> sellerMultiListingPackageGV =
    {}; // Todo: Need to add for globally provider
bool loginAsGuestGV = false;
String listingSelectedCategoryGV = '';
String profileVerificationStatusGV = '';

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
