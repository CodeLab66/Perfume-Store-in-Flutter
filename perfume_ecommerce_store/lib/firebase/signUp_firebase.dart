import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // Update display name in FirebaseAuth
      await userCredential.user!.updateDisplayName(name.trim());

      // Store user data in Firestore
      final userDoc = _firestore
          .collection('users')
          .doc(userCredential.user!.uid);
      await userDoc.set({
        'fullName': name.trim(),
        'email': email.trim(),
        'address': null,
        'phoneNumber': null,
        'paymentMethod': null,
        'paymentNumber': null,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // No error, signup successful
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code); // Return error message
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'The email address is already in use';
      case 'invalid-email':
        return 'The email address is not valid';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      case 'weak-password':
        return 'The password is too weak';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
