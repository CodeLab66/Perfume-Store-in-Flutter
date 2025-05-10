class Product {
  final String title;
  final String subtitle;
  final double price;
  final String imagePath;

  Product({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imagePath: data['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'imagePath': imagePath,
    };
  }
}
