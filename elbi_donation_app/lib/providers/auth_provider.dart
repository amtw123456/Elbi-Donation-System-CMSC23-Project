import 'package:elbi_donation_app/api/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _userStream;

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser();

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchUser();
  }

  void fetchUser() {
    _userStream = authService.fetchUser();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}
