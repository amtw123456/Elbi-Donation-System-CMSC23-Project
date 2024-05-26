import '../models/donation_model.dart';

class DonationDriveModel {
  String? id;
  String? organizationId;
  String? donationDriveName;
  String? donationDriveDescription;
  List<DonationModel>? listOfDonationsId;

  DonationDriveModel({
    this.id,
    this.organizationId,
    this.donationDriveName,
    this.donationDriveDescription,
    List<DonationModel>? listOfDonationsId,
  }) : listOfDonationsId = listOfDonationsId ?? [];

  // Factory constructor to instantiate object from json format
  factory DonationDriveModel.fromJson(Map<String, dynamic> json) {
    return DonationDriveModel(
      id: json['id'],
      organizationId: json['organizationId'],
      donationDriveName: json['donationDriveName'],
      donationDriveDescription: json['donationDriveDescription'],
      listOfDonationsId: (json['listOfDonationsId'] as List<dynamic>?)
          ?.map((item) => DonationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(DonationDriveModel donationDriveModel) {
    return {
      'id': id,
      'organizationId': organizationId,
      'donationDriveName': donationDriveName,
      'donationDriveDescription': donationDriveDescription,
      'listOfDonationsId':
          listOfDonationsId?.map((item) => item.toJson(item)).toList(),
    };
  }

  // Method to add a donation to the list
  void addDonation(DonationModel donation) {
    listOfDonationsId?.add(donation);
  }
}
