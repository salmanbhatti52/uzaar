class ProductCategoryClass {
  final String image;
  final String catName;

  ProductCategoryClass({required this.image, required this.catName});
}

final productCategoryModel = [
  ProductCategoryClass(image: 'assets/printing.svg', catName: 'Electronics'),
  ProductCategoryClass(image: 'assets/vehical.svg', catName: 'Vehicle'),
  ProductCategoryClass(image: 'assets/fashion.svg', catName: 'Fashion'),
  ProductCategoryClass(image: 'assets/books (2).svg', catName: 'Books'),
  ProductCategoryClass(image: 'assets/furniture.svg', catName: 'Furniture'),
  ProductCategoryClass(image: 'assets/sports.svg', catName: 'Sports'),
  ProductCategoryClass(image: 'assets/accessories.svg', catName: 'Accessories'),
];
