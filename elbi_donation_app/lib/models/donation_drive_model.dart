import '../models/donation_model.dart';

class DonationDriveModel {
  String? id;
  String? organizationId;
  String? donationDriveName;
  String? donationDriveDescription;
  String? donationDriveImageCover;
  List<DonationModel>? listOfDonationsId;

  DonationDriveModel({
    this.id,
    this.organizationId,
    this.donationDriveName,
    this.donationDriveDescription,
    this.donationDriveImageCover,
    List<String>? listOfDonationsId,
  });

  // Factory constructor to instantiate object from json format
  factory DonationDriveModel.fromJson(Map<String, dynamic> json) {
    return DonationDriveModel(
        id: json['id'],
        organizationId: json['organizationId'],
        donationDriveName: json['donationDriveName'],
        donationDriveDescription: json['donationDriveDescription'],
        donationDriveImageCover: json['donationDriveImageCover'],
        listOfDonationsId: json['listOfDonationsId'] != null
            ? List<String>.from(json['listOfDonationsId'])
            : null);
  }

  Map<String, dynamic> toJson(DonationDriveModel donationDriveModel) {
    return {
      'id': id,
      'organizationId': organizationId,
      'donationDriveName': donationDriveName,
      'donationDriveDescription': donationDriveDescription,
      'donationDriveImageCover': donationDriveImageCover,
      'listOfDonationsId':
          listOfDonationsId?.map((item) => item.toJson(item)).toList(),
    };
  }

  // Method to add a donation to the list
  void addDonation(DonationModel donation) {
    listOfDonationsId?.add(donation);
  }
}
