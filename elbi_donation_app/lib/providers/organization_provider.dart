import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/api/firebase_organization_api.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';
import 'package:flutter/material.dart';

class OrganizationProvider with ChangeNotifier {
  fireBaseOrganizationAPI firebaseService = fireBaseOrganizationAPI();
  late final Stream<QuerySnapshot> donationDriveStream;
  OrganizationProvider() {
    donationDriveStream = firebaseService.donationDriveStream;
  }

  Future<Map<String, dynamic>> addDonationDriveModel(
      DonationDriveModel donationDriveModel) async {
    final result = await firebaseService
        .addDonationDriveModel(donationDriveModel.toJson(donationDriveModel));
    return result;
  }

  Future<Map<String, dynamic>> updateDonationDriveModel(
      String id, Map<String, dynamic> updates) async {
    final result = await firebaseService.updateDonationDrives(id, updates);
    return result;
  }

  Future<Map<String, dynamic>> deleteDonationDriveModel(String id) async {
    final result = await firebaseService.deleteDonationDriveModel(id);
    return result;
  }

  Future<Map<String, dynamic>> getDonationDriveModel(String id) async {
    final result = await firebaseService.getDonationDriveModel(id);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> getOrganizationDonationDrives() async {
    final result = await firebaseService.getOrganizationDonationDrives();
    return result;
  }
}
