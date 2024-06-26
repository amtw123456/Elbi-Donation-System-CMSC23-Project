import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/donation_model.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // add a donation
  Future<Map<String, dynamic>> addDonationModel(
      Map<String, dynamic> donationModel) async {
    try {
      await db
          .collection("donationModels")
          .doc(donationModel['id'])
          .set(donationModel);

      return {'success': true, 'message': "Successfully added!"};
    } on FirebaseException catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> updateDonationModel(
      String id, Map<String, dynamic> updates) async {
    try {
      await FirebaseFirestore.instance
          .collection("donationModels")
          .doc(id)
          .update(updates);

      return {'success': true, 'message': "Successfully updated!"};
    } on FirebaseException catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteDonationModel(String id) async {
    try {
      await db.collection("donationModels").doc(id).delete();

      return {'success': true, 'message': "Successfully deleted!"};
    } on FirebaseException catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> getDonationModel(String id) async {
    try {
      final doc = await db.collection("donationModels").doc(id).get();
      DonationModel donationModel =
          DonationModel.fromJson(doc.data() as Map<String, dynamic>);
      return {'success': true, 'donationModel': donationModel};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

// get all donations that the donor has sent
  Future<List<DonationModel>?> getAllDonations(String donorId) async {
    try {
      List<DonationModel> donations = [];
      final snapshots = await db
          .collection("donationModels")
          .where("donorId", isEqualTo: donorId)
          .get();
      for (var snapshot in snapshots.docs) {
        donations.add(DonationModel.fromJson(snapshot.data()));
      }
      return donations;
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
    return null;
  }

  // TODO: Add Cancel Donation
}
