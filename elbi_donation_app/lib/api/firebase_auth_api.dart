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

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return ('Firebase Error: ${e.code} : ${e.message}');
    } catch (e) {
      return ('Error: $e');
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseException catch (e) {
      return ('Firebase Error: ${e.code} : ${e.message}');
    } catch (e) {
      return ('Error: $e');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
