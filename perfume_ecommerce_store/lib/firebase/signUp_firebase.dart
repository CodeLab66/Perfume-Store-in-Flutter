import 'package:firebase_auth/firebase_auth.dart';

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

      // Update display name
      await userCredential.user!.updateDisplayName(name.trim());

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
