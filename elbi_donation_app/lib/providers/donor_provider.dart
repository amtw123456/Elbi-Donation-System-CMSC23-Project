import 'package:elbi_donation_app/api/firebase_donor_api.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:flutter/material.dart';

class DonorProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();

  Future<Map<String, dynamic>> addDonationModel(
      DonationModel donationModel) async {
    final result = await firebaseService
        .addDonationModel(donationModel.toJson(donationModel));
    return result;
  }

  Future<Map<String, dynamic>> deleteDonationModel(String id) async {
    final result = await firebaseService.deleteDonationModel(id);
    return result;
  }

  Future<Map<String, dynamic>> updateDonationModel(
      String id, Map<String, dynamic> updates) async {
    final result = await firebaseService.updateDonationModel(id, updates);
    return result;
  }

  Future<Map<String, dynamic>> getDonationModel(String id) async {
    final result = await firebaseService.getDonationModel(id);
    return result;
  }

  Future<List<DonationModel>?> getAllDonations(String donorId) async {
    List<DonationModel>? donations =
        await firebaseService.getAllDonations(donorId);
    return donations;
  }
}
