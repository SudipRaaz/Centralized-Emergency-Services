import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyCloudStoreBase {
  // registering user data to database
  Future registerUser(String? uid, String name, String email, int phoneNumber);

  Future requestService(
      String uid,
      bool ambulance,
      bool fireBrigade,
      bool police,
      String message,
      double latitude,
      double longitude,
      DateTime timestamp,
      String status);

  Stream<QuerySnapshot> getHistory(uid) {
    return FirebaseFirestore.instance
        .collection('Customer')
        .doc('Requests')
        .collection(uid)
        .snapshots();
  }

  Future submitFeedback(int? rating, String? comment, String? report);
}
