class HousingCategoryClass {
  final String image;
  final String houseName;

  HousingCategoryClass({required this.image, required this.houseName});
}

final housingCategoryModel = [
  HousingCategoryClass(image: 'assets/rental.svg', houseName: 'Rental'),
  HousingCategoryClass(image: 'assets/forsale.svg', houseName: 'For Sale'),
  HousingCategoryClass(image: 'assets/lease.svg', houseName: 'Lease'),
];
