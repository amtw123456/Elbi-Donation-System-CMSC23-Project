import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/user_model.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _organizationsStream =
      db.collection('userModels').snapshots();
  Stream<QuerySnapshot> get orgStream => _organizationsStream;

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

  Future<Map<String, dynamic>> updateUserModel(
      String id, Map<String, dynamic> updates) async {
    try {
      // Update the document with the given id
      if (updates['organizationDriveList'] != null) {
        // Use FieldValue.arrayUnion for organizationDriveList
        updates['organizationDriveList'] = FieldValue.arrayUnion(
            updates['organizationDriveList'] is List
                ? updates['organizationDriveList']
                : [updates['organizationDriveList']]);
      }

      if (updates['donationsList'] != null) {
        // Use FieldValue.arrayUnion for organizationDriveList
        updates['donationsList'] = FieldValue.arrayUnion(
            updates['donationsList'] is List
                ? updates['donationsList']
                : [updates['donationsList']]);
      }

      await FirebaseFirestore.instance
          .collection("userModels")
          .doc(id)
          .update(updates);

      return {'success': true, 'message': "Successfully updated!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> removeDonationDriveModelFromUserModel(
      String userId, String driveId) async {
    try {
      await db.collection("userModels").doc(userId).update({
        'organizationDriveList': FieldValue.arrayRemove([driveId])
      });
      return {'success': true, 'message': "Successfully updated!"};
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

  Future<Map<String, dynamic>> getDonors() async {
    try {
      List<UserModel> donors = [];
      final snapshots = await db
          .collection("userModels")
          .where("type", isEqualTo: "donor")
          .get();
      for (var snapshot in snapshots.docs) {
        donors.add(UserModel.fromJson(snapshot.data()));
      }
      return {'success': true, 'donors': donors};
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
