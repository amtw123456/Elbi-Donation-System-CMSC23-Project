import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  late FirebaseAuth auth;

  FirebaseAuthAPI() {
    auth = FirebaseAuth.instance;
  }

  Stream<User?> fetchUser() {
    return auth.authStateChanges();
  }

  User? getUser() {
    return auth.currentUser;
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {'success': true, 'uid': userCredential.user?.uid};
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'error': 'The account already exists for that email.'
        };
      } else {
        return {
          'success': false,
          'error': 'Firebase Error: ${e.code} : ${e.message}'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return {'success': true, 'uid': userCredential.user?.uid};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    try {
      await auth.signOut();
      return {'success': true, 'error': 'Logout successful.'};
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }
}
