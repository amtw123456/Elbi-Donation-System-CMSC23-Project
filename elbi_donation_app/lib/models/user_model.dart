import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username; // can be used for org name
  String email;
  String? address;
  String? contactNumber;
  String? type;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      required this.email,
      this.address,
      this.contactNumber,
      this.type});

  // Factory constructor to instantiate object from json format
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      contactNumber: json['contactNumber'],
      type: json['type'],
    );
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
      'email': userModel.email,
      'address': userModel.address,
      'contactNumber': userModel.contactNumber,
      'type': userModel.type
    };
  }
}
