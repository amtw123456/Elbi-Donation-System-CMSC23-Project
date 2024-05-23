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
    fetchAuthentication();
  }

  void fetchAuthentication() {
    _userStream = authService.fetchUser();
    notifyListeners();
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final result = await authService.signUp(email, password);
    return result;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final result = await authService.signIn(email, password);
    return result;
  }

  Future<Map<String, dynamic>> signOut() async {
    final result = await authService.signOut();
    return result;
  }
}
