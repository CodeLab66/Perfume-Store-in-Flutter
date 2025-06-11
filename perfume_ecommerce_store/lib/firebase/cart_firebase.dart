import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;

  // Add or update item in cart (by productName and size)
  Future<void> addOrUpdateCartItem(Map<String, dynamic> product) async {
    if (userId == null) return;
    final userRef = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      List<dynamic> cart = snapshot.data()?['cart'] ?? [];

      int index = cart.indexWhere(
        (item) =>
            item['productName'] == product['productName'] &&
            item['size'] == product['size'],
      );

      if (index != -1) {
        cart[index]['quantity'] += product['quantity'];
      } else {
        cart.add(product);
      }

      transaction.update(userRef, {'cart': cart});
    });
  }

  // Remove item from cart (by productName and size)
  Future<void> removeCartItem(String productName, String size) async {
    if (userId == null) return;
    final userRef = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      List<dynamic> cart = snapshot.data()?['cart'] ?? [];
      cart.removeWhere(
        (item) => item['productName'] == productName && item['size'] == size,
      );
      transaction.update(userRef, {'cart': cart});
    });
  }

  // Update quantity for a cart item
  Future<void> updateCartItemQuantity(
    String productName,
    String size,
    int quantity,
  ) async {
    if (userId == null) return;
    final userRef = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      List<dynamic> cart = snapshot.data()?['cart'] ?? [];
      int index = cart.indexWhere(
        (item) => item['productName'] == productName && item['size'] == size,
      );
      if (index != -1) {
        cart[index]['quantity'] = quantity;
        transaction.update(userRef, {'cart': cart});
      }
    });
  }

  // Clear the cart
  Future<void> clearCart() async {
    if (userId == null) return;
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.update({'cart': []});
  }

  // Fetch cart as a stream
  Stream<List<Map<String, dynamic>>> fetchCartItems() {
    if (userId == null) return const Stream.empty();
    final userRef = _firestore.collection('users').doc(userId);
    return userRef.snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data()?['cart'] != null) {
        return List<Map<String, dynamic>>.from(snapshot.data()!['cart']);
      } else {
        return [];
      }
    });
  }
}
