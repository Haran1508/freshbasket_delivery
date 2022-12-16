import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String phonenumber;
  final String pincode;
  final String location;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.pincode,
    required this.location,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'pincode': pincode,
      'location': location,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      pincode: map['pincode'] ?? '',
      location: map['location'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
