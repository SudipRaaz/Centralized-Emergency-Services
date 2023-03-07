import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/cloud_firestore_base.dart';
import 'package:ems_project/model/request_model.dart';
import 'package:flutter/material.dart';
import '../model/feedback_model.dart';
import '../model/registration_model.dart';

class MyCloudStore extends MyCloudStoreBase {
  @override
  Future registerUser(
      String? uid, String name, String email, int phoneNumber) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);

    final user =
        RegistrationModel(name: name, phoneNumber: phoneNumber, email: email);
    // wating for doc set josn object on firebase
    await docUser.set(user.toJson());
  }

  @override
  Future requestService(
      String uid,
      bool ambulance,
      bool fireBrigade,
      bool police,
      String message,
      double latitude,
      double longitude,
      DateTime timestamp,
      String status) async {
    // document references
    final docReq = FirebaseFirestore.instance
        .collection('CustomerRequests')
        .doc('Requests')
        .collection(uid)
        .doc();
    // model fill
    final request = RequestModel(
        uid: uid,
        ambulanceService: ambulance,
        fireBrigadeService: fireBrigade,
        policeService: police,
        message: message,
        latitude: latitude,
        longitude: longitude,
        requestedAt: timestamp,
        status: status);
    await docReq.set(request.toJson());
  }

  @override
  Future submitFeedback(int? rating, String? comment, String? report) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('CustomerCare').doc();

    final feeback =
        CustomerCare(rating: rating, comment: comment, report: report);
    // wating for doc set josn object on firebase
    await docUser.set(feeback.toJson());
  }
}
