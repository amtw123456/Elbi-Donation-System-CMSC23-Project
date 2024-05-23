import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? orgName;
  String email;
  String? address;
  String? contactNumber;
  // this could be 'admin', 'org', or 'donor'
  String? type; // this refers to the user type
  bool? isApprovedByAdmin; // approval first if they're an org

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.orgName,
      required this.email,
      this.address,
      this.contactNumber,
      this.type,
      this.isApprovedByAdmin});

  // Factory constructor to instantiate object from json format
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
        isApprovedByAdmin: json['isApprovedByAdmin']);
  }

  static List<UserModel> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserModel>((dynamic d) => UserModel.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'id': userModel.id,
      'firstName': userModel.firstName,
      'lastName': userModel.lastName,
      'username': userModel.username,
      'orgName': userModel.orgName,
      'email': userModel.email,
      'address': userModel.address,
      'contactNumber': userModel.contactNumber,
      'type': userModel.type,
      'isApprovedByAdmin': userModel.isApprovedByAdmin
    };
  }
}
