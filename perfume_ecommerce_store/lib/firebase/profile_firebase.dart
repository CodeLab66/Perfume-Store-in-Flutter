import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch current user data
  Future<Map<String, dynamic>?> fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data();
  }

  // Update user data (including payment fields)
  Future<void> updateUserData(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection('users').doc(user.uid).update(data);
  }
}
