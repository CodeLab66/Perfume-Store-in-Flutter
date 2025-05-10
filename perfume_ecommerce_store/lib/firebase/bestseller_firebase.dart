import 'package:cloud_firestore/cloud_firestore.dart';

class BestSellerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch products from Firestore based on category "Best Seller"
  Stream<List<Product>> fetchBestSellers() {
    return _db
        .collection('products')
        .where(
          'category',
          arrayContains: 'Best Seller',
        ) // Fetch products categorized as Best Seller
        .snapshots()
        .map(
          (snap) =>
              snap.docs
                  .map((doc) => Product.fromFirestore(doc.data()))
                  .toList(),
        );
  }
}

class Product {
  final String name;
  final String size;
  final String image;
  final double price;

  Product({
    required this.name,
    required this.size,
    required this.image,
    required this.price,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    final rawImage = data['image'] as String? ?? '';
    return Product(
      name: data['name'] as String? ?? '',
      size: data['size'] as String? ?? '',
      image: _formatGoogleDriveImageURL(rawImage),
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static String _formatGoogleDriveImageURL(String urlOrId) {
    if (urlOrId.startsWith('http')) return urlOrId;
    return 'https://drive.google.com/uc?id=$urlOrId';
  }
}
