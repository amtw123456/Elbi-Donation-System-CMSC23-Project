import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _donationDriveStreams =
      db.collection('donationDriveModels').snapshots();
  Stream<QuerySnapshot> get orgStream => _donationDriveStreams;

  // make sure that the id is already present
  // (the id should be the same as the auth id)
  Future<Map<String, dynamic>> addDonationDriveModel(
      Map<String, dynamic> donationDriveModel) async {
    try {
      await db
          .collection("donationDriveModels")
          .doc(donationDriveModel['id'])
          .set(donationDriveModel);

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

  Future<Map<String, dynamic>> deleteDonationDriveModel(String id) async {
    try {
      await db.collection("donationDriveModels").doc(id).delete();

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

  Future<Map<String, dynamic>> getDonationDriveModel(String id) async {
    try {
      final doc = await db.collection("donationDriveModels").doc(id).get();
      DonationDriveModel donationDriveModel =
          DonationDriveModel.fromJson(doc.data() as Map<String, dynamic>);
      return {'success': true, 'donationDriveModel': donationDriveModel};
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
  Future<Map<String, dynamic>> getOrganizationDonationDrives() async {
    try {
      List<DonationDriveModel> orgs = [];
      final snapshots = await db
          .collection("donationDriveModels")
          .where("type", isEqualTo: "org")
          .get();
      for (var snapshot in snapshots.docs) {
        orgs.add(DonationDriveModel.fromJson(snapshot.data()));
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
