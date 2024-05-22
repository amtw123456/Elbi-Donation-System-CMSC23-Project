import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/donation_model.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // add a donation
  Future<String> addDonationModel(Map<String, dynamic> donationModel) async {
    try {
      await db
          .collection("donationModels")
          .doc(donationModel['id'])
          .set(donationModel);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> deleteDonationModel(String id) async {
    try {
      await db.collection("donationModels").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<DonationModel?> getDonationModel(String id) async {
    try {
      final doc = await db.collection("donationModels").doc(id).get();
      DonationModel donationModel =
          DonationModel.fromJson(doc.data() as Map<String, dynamic>);
      return donationModel;
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
    return null;
  }
}
