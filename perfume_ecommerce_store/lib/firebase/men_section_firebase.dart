import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_firebase.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Stream<List<Product>> fetchMenProducts() {
  return _db
      .collection('products')
      .where('category', arrayContains: 'Men')
      .snapshots()
      .map(
        (snap) =>
            snap.docs.map((doc) => Product.fromFirestore(doc.data())).toList(),
      );
}
