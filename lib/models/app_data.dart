import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  List<dynamic> featuredProductsGV = [];
  List<dynamic> featuredServicesGV = [];
  List<dynamic> featuredHousingGV = [];
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
  List<dynamic> listedProductsGV = [];
  List<dynamic> listedServicesGV = [];
  List<dynamic> listedHousingsGV = [];
  List<dynamic> boostingPackagesGV = [];
  Map<String, dynamic> userDataGV = {};
  bool loginAsGuestGV = false;
  String listingSelectedCategoryGV = '';
  String profileVerificationStatusGV = '';

  void clearData() {
    featuredProductsGV.clear();
    featuredServicesGV.clear();
    featuredHousingGV.clear();
    listingTypesGV.clear();
    allListingsProductsGV.clear();
    allListingsServicesGV.clear();
    allListingsHousingsGV.clear();
    productListingCategoriesGV.clear();
    serviceListingCategoriesGV.clear();
    housingListingCategoriesGV.clear();
    productsPriceRangesGV.clear();
    servicesPriceRangesGV.clear();
    housingsPriceRangesGV.clear();
    listedProductsGV.clear();
    listedServicesGV.clear();
    listedHousingsGV.clear();
    boostingPackagesGV.clear();
    userDataGV.clear();
    loginAsGuestGV = false;
    listingSelectedCategoryGV = '';
    profileVerificationStatusGV = '';

    notifyListeners();
  }
}
