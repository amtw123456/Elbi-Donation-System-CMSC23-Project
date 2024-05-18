import 'package:elbi_donation_app/api/firebase_user_api.dart';
import 'package:elbi_donation_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseUserAPI firebaseService = FirebaseUserAPI();

  void addUserModel(UserModel userModel) async {
    String message =
        await firebaseService.addUserModel(userModel.toJson(userModel));
    print(message);
    notifyListeners();
  }

  void deleteUserModel(String id) async {
    await firebaseService.deleteUserModel(id);
    notifyListeners();
  }

  Future<UserModel?> getUserModel(String id) async {
    UserModel? userModel = await firebaseService.getUserModel(id);
    return userModel;
  }
}
