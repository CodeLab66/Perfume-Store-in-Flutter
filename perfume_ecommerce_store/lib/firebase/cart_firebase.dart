import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initializeCart() async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartDoc = _firestore.collection('cart').doc(user.uid);
      final cartSnapshot = await cartDoc.get();

      if (!cartSnapshot.exists) {
        await cartDoc.set({'items': []});
      }
    }
  }

  Future<void> addItemToCart(Map<String, dynamic> item) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartDoc = _firestore.collection('cart').doc(user.uid);
      final cartSnapshot = await cartDoc.get();
      
      if (cartSnapshot.exists) {
        final items = List<Map<String, dynamic>>.from(cartSnapshot.data()!['items']);
        final existingItemIndex = items.indexWhere((i) => i['productId'] == item['productId']);

        if (existingItemIndex != -1) {
          // Update existing item
          items[existingItemIndex] = item;
        } else {
          // Add new item
          items.add(item);
        }

        await cartDoc.update({'items': items});
      } else {
        // Create new cart with item
        await cartDoc.set({
          'items': [item]
        });
      }
    }
  }

  Future<void> removeItemFromCart(Map<String, dynamic> item) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartDoc = _firestore.collection('cart').doc(user.uid);
      final cartSnapshot = await cartDoc.get();
      
      if (cartSnapshot.exists) {
        final items = List<Map<String, dynamic>>.from(cartSnapshot.data()!['items']);
        items.removeWhere((i) => i['productId'] == item['productId']);
        await cartDoc.update({'items': items});
      }
    }
  }

  Stream<List<Map<String, dynamic>>> getCartItems() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('cart').doc(user.uid).snapshots().map((snapshot) {
        if (snapshot.exists && snapshot.data()?['items'] != null) {
          return List<Map<String, dynamic>>.from(snapshot.data()!['items']);
        }
        return [];
      });
    }
    return Stream.value([]);
  }
}