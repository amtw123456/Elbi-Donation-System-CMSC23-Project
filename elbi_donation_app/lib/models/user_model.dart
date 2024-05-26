import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String email;
  String? address;
  String? contactNumber;
  String? type;
  bool? isApprovedByAdmin;
  String? orgName;
  String? status;
  String? orgDescription;
  List<String>? organizationDriveList; // New list field

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
    this.orgDescription,
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
      address: json['address'],
      contactNumber: json['contactNumber'],
      type: json['type'],
      isApprovedByAdmin: json['isApprovedByAdmin'],
      status: json['status'],
      orgDescription: json['orgDescription'],
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
      'contactNumber': contactNumber,
      'type': type,
      'isApprovedByAdmin': isApprovedByAdmin,
      'status': status,
      'orgDescription': orgDescription,
      'organizationDriveList':
          organizationDriveList, // Include organizationDriveList in JSON
    };
  }
}
