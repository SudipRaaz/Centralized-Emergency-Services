import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/cloud_firestore_base.dart';
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
}
