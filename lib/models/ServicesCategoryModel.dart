class ServicesCategory {
  final String image;
  final String serviceName;

  ServicesCategory({required this.image, required this.serviceName});
}

final servicesCategoryModel = [
  ServicesCategory(image: 'assets/tech.svg', serviceName: 'Tech'),
  ServicesCategory(image: 'assets/designing.svg', serviceName: 'Design'),
  ServicesCategory(image: 'assets/beauty.svg', serviceName: 'Beauty'),
  ServicesCategory(image: 'assets/medical.svg', serviceName: 'Medical'),
  ServicesCategory(image: 'assets/printing.svg', serviceName: 'Printing'),
];
