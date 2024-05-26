import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? address;
  String? contactNumber;
  String? type;
  bool? isApprovedByAdmin;
  String? orgName;
  String? status;
  String? orgDescription;
  List<String>
      organizationDonationDrivesList; // Adjusted to have a default empty list

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.orgName,
    required this.email,
    this.address,
    this.contactNumber,
    this.type,
    this.isApprovedByAdmin,
    this.status,
    List<String>?
        organizationDonationDrivesList, // Updated parameter to accept null
    this.orgDescription,
  }) : organizationDonationDrivesList =
            organizationDonationDrivesList ?? []; // Set default value

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      orgName: json['orgName'],
      email: json['email'],
      address: json['address'],
      contactNumber: json['contactNumber'],
      type: json['type'],
      isApprovedByAdmin: json['isApprovedByAdmin'],
      status: json['status'],
      orgDescription: json['orgDescription'],
      organizationDonationDrivesList:
          List<String>.from(json['organizationDonationDrivesList'] ?? []),
    );
  }

  static List<UserModel> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserModel>((dynamic d) => UserModel.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'orgName': orgName,
      'email': email,
      'address': address,
      'contactNumber': contactNumber,
      'type': type,
      'isApprovedByAdmin': isApprovedByAdmin,
      'status': status,
      'orgDescription': orgDescription,
      'organizationDonationDrivesList': organizationDonationDrivesList,
    };
  }
}
