import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/api/firebase_user_api.dart';
import 'package:elbi_donation_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseUserAPI firebaseService = FirebaseUserAPI();
  late final Stream<QuerySnapshot> orgStream;
  UserProvider() {
    orgStream = firebaseService.orgStream;
  }

  Future<Map<String, dynamic>> addUserModel(UserModel userModel) async {
    final result =
        await firebaseService.addUserModel(userModel.toJson(userModel));
    return result;
  }

  Future<Map<String, dynamic>> updateUserModel(
      String id, Map<String, dynamic> updates) async {
    final result = await firebaseService.updateUserModel(id, updates);
    return result;
  }

  Future<Map<String, dynamic>> deleteUserModel(String id) async {
    final result = await firebaseService.deleteUserModel(id);
    return result;
  }

  Future<Map<String, dynamic>> getUserModel(String id) async {
    final result = await firebaseService.getUserModel(id);
    return result;
  }

  Future<Map<String, dynamic>> getOrganizations() async {
    final result = await firebaseService.getOrganizations();
    return result;
  }

  Future<Map<String, dynamic>> getDonors() async {
    final result = await firebaseService.getDonors();
    return result;
  }

  Future<Map<String, dynamic>> removeDonationDriveModelFromUserModel(
      String userid, String driveid) async {
    final result = await firebaseService.removeDonationDriveModelFromUserModel(
        userid, driveid);
    notifyListeners();
    return result;
  }
}
