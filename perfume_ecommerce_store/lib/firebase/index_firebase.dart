// lib/firebase/index_firebase.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch products from Firestore based on category (arrayContains!)
  Stream<List<Product>> fetchProductsByCategory(String category) {
    return _db
        .collection('products')
        .where('category', arrayContains: category) // ← use arrayContains
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
  final String description;
  final String image;
  final double price;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    final rawImage = data['image'] as String? ?? '';
    return Product(
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      image: _formatGoogleDriveImageURL(rawImage),
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static String _formatGoogleDriveImageURL(String urlOrId) {
    if (urlOrId.startsWith('http')) return urlOrId;
    return 'https://drive.google.com/uc?id=$urlOrId';
  }
}
