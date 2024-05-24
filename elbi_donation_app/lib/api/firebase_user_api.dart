import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/user_model.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // make sure that the id is already present
  // (the id should be the same as the auth id)
  Future<Map<String, dynamic>> addUserModel(
      Map<String, dynamic> userModel) async {
    try {
      await db.collection("userModels").doc(userModel['id']).set(userModel);

      return {'success': true, 'message': "Successfully added!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteUserModel(String id) async {
    try {
      await db.collection("userModels").doc(id).delete();

      return {'success': true, 'message': "Successfully deleted!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> getUserModel(String id) async {
    try {
      final doc = await db.collection("userModels").doc(id).get();
      UserModel userModel =
          UserModel.fromJson(doc.data() as Map<String, dynamic>);
      return {'success': true, 'userModel': userModel};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  // view all organizations
  Future<Map<String, dynamic>> getOrganizations() async {
    try {
      List<UserModel> orgs = [];
      final snapshots = await db
          .collection("userModels")
          .where("type", isEqualTo: "org")
          .get();
      for (var snapshot in snapshots.docs) {
        orgs.add(UserModel.fromJson(snapshot.data()));
      }
      return {'success': true, 'orgs': orgs};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }
}
