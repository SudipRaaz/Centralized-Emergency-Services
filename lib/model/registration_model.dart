import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationModel {
  String name;
  int phoneNumber;
  String email;

  RegistrationModel(
      {required this.name, required this.phoneNumber, required this.email});

  factory RegistrationModel.fromJson(Map<dynamic, dynamic> json) {
    return RegistrationModel(
        name: json['Name'],
        phoneNumber: int.parse(json['PhoneNumber']),
        email: json['Email']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Email': email
    };
  }

  factory RegistrationModel.fromSnapshot(DocumentSnapshot snapshot) {
    final registration =
        RegistrationModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return registration;
  }
}
