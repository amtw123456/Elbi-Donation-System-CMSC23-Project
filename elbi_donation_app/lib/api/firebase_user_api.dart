import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/user_model.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // make
  Future<String> addUserModel(Map<String, dynamic> userModel) async {
    try {
      await db.collection("userModels").doc(userModel['id']).set(userModel);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> deleteUserModel(String id) async {
    try {
      await db.collection("userModels").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<UserModel?> getUserModel(String id) async {
    try {
      final doc = await db.collection("userModels").doc(id).get();
      UserModel userModel =
          UserModel.fromJson(doc.data() as Map<String, dynamic>);
      return userModel;
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
    return null;
  }
}
