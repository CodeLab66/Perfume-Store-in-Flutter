import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_firebase.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> fetchProductsByCategory(String category) {
    return _db
        .collection('products')
        .where('category', arrayContains: category)
        .snapshots()
        .map(
          (snap) =>
              snap.docs
                  .map((doc) => Product.fromFirestore(doc.data()))
                  .toList(),
        );
  }
}
