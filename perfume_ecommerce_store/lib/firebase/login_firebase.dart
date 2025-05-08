import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Login successful
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'invalid-email':
        return 'The email address is not valid';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
