import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
final FirebaseAuth _auth = FirebaseAuth.instance;

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

Future<List<String>> fetchUserFavorites() async {
  final user = _auth.currentUser;
  if (user == null) return [];
  final doc = await _db.collection('users').doc(user.uid).get();
  final data = doc.data();
  if (data == null || data['favorites'] == null) return [];
  return List<String>.from(data['favorites']);
}

Stream<List<String>> userFavoritesStream() {
  final user = _auth.currentUser;
  if (user == null) return const Stream.empty();
  return _db.collection('users').doc(user.uid).snapshots().map((doc) {
    final data = doc.data();
    if (data == null || data['favorites'] == null) return <String>[];
    return List<String>.from(data['favorites']);
  });
}

Future<void> setUserFavorites(List<String> favorites) async {
  final user = _auth.currentUser;
  if (user == null) return;
  await _db.collection('users').doc(user.uid).set({
    'favorites': favorites,
  }, SetOptions(merge: true));
}

Future<void> addFavorite(String productId) async {
  final user = _auth.currentUser;
  if (user == null) return;
  final docRef = _db.collection('users').doc(user.uid);
  await docRef.set({
    'favorites': FieldValue.arrayUnion([productId]),
  }, SetOptions(merge: true));
}

Future<void> removeFavorite(String productId) async {
  final user = _auth.currentUser;
  if (user == null) return;
  final docRef = _db.collection('users').doc(user.uid);
  await docRef.set({
    'favorites': FieldValue.arrayRemove([productId]),
  }, SetOptions(merge: true));
}
