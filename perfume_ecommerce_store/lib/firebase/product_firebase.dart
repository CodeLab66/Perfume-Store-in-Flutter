import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String description;
  final String image;
  final double price;
  final String size;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.size,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    final rawImage = data['image'] as String? ?? '';
    return Product(
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      image: _formatGoogleDriveImageURL(rawImage),
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      size: data['size'] as String? ?? '',
    );
  }

  static String _formatGoogleDriveImageURL(String urlOrId) {
    if (urlOrId.startsWith('http')) return urlOrId;
    return 'https://drive.google.com/uc?id=$urlOrId';
  }
}

final FirebaseFirestore _db = FirebaseFirestore.instance;

Stream<Product> fetchProductByName(String name) {
  return _db
      .collection('products')
      .where('name', isEqualTo: name)
      .limit(1)
      .snapshots()
      .map(
        (snap) =>
            snap.docs.isNotEmpty
                ? Product.fromFirestore(snap.docs.first.data())
                : throw Exception('Product not found'),
      );
}
