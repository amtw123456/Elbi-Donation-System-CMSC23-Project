import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String email;
  List<String>? address;
  List<String>? donationsList;
  String? contactNumber;
  String? type;
  bool? isApprovedByAdmin;
  String? orgName;
  String? status;
  String? orgDescription;
  String? proofOfLegitimacyImageUrlLink;
  List<String>? organizationDriveList; // New list field

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.orgName,
    required this.email,
    this.address,
    this.donationsList,
    this.contactNumber,
    this.type,
    this.isApprovedByAdmin,
    this.status,
    this.orgDescription,
    this.proofOfLegitimacyImageUrlLink,
    this.organizationDriveList, // Add organizationDriveList to the constructor
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      orgName: json['orgName'],
      email: json['email'],

      contactNumber: json['contactNumber'],
      type: json['type'],
      isApprovedByAdmin: json['isApprovedByAdmin'],
      status: json['status'],
      orgDescription: json['orgDescription'],
      proofOfLegitimacyImageUrlLink: json['proofOfLegitimacyImageUrlLink'],
      donationsList: json['donationsList'] != null
          ? List<String>.from(json['donationsList'])
          : null,
      address:
          json['address'] != null ? List<String>.from(json['address']) : null,
      organizationDriveList: json['organizationDriveList'] != null
          ? List<String>.from(json['organizationDriveList'])
          : null, // Parse organizationDriveList from JSON
    );
  }

  static List<UserModel> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserModel>((dynamic d) => UserModel.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserModel userModel) {
    // Removed userModel parameter
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'orgName': orgName,
      'email': email,
      'address': address,
      'donationsList': donationsList,
      'contactNumber': contactNumber,
      'type': type,
      'isApprovedByAdmin': isApprovedByAdmin,
      'status': status,
      'orgDescription': orgDescription,
      'proofOfLegitimacyImageUrlLink': proofOfLegitimacyImageUrlLink,
      'organizationDriveList':
          organizationDriveList, // Include organizationDriveList in JSON
    };
  }
}
