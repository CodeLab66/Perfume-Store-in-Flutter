import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_aut/firebase_auth.dart';

class CartFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  // Add or Update Item in Cart
  Future<void> addOrUpdateCartItem(Map<String, dynamic> cartItem) async {
    final cartRef = _firestore.collection('cart').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartRef);

      if (!snapshot.exists) {
        // Create cart document if it doesn't exist
        transaction.set(cartRef, {
          'cartItems': [cartItem],
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Update cart document
        List<dynamic> cartItems = snapshot.get('cartItems') ?? [];
        int index = cartItems.indexWhere((item) => item['productId'] == cartItem['productId']);

        if (index != -1) {
          // Update existing item quantity
          cartItems[index]['quantity'] += cartItem['quantity'];
        } else {
          // Add new item
          cartItems.add(cartItem);
        }

        transaction.update(cartRef, {'cartItems': cartItems});
      }
    });
  }

  // Remove Item from Cart
  Future<void> removeCartItem(String productId) async {
    final cartRef = _firestore.collection('cart').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartRef);

      if (snapshot.exists) {
        List<dynamic> cartItems = snapshot.get('cartItems') ?? [];
        cartItems.removeWhere((item) => item['productId'] == productId);

        transaction.update(cartRef, {'cartItems': cartItems});
      }
    });
  }

  // Fetch Cart Items
  Stream<List<Map<String, dynamic>>> fetchCartItems() {
    final cartRef = _firestore.collection('cart').doc(userId);

    return cartRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return List<Map<String, dynamic>>.from(snapshot.get('cartItems') ?? []);
      } else {
        return [];
      }
    });
  }

  // Clear Cart
  Future<void> clearCart() async {
    final cartRef = _firestore.collection('cart').doc(userId);

    await cartRef.update({'cartItems': []});
  }
}