import 'package:ems_project/Controller/authentication_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utilities/InfoDisplay/message.dart';
import 'cloud_firestore.dart';
import 'cloud_firestore_base.dart';

class Authentication extends AuthenticationBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.idTokenChanges();

  @override
  Future createUserWithEmailAndPassword(BuildContext context, String email,
      String password, String name, int phoneNumber) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyCloudStoreBase obj = MyCloudStore();
      obj.registerUser(
          Authentication().currentUser?.uid, name, email, phoneNumber);
    } on FirebaseAuthException catch (error) {
      Message.flutterToast(context, error.message.toString());
      // catch any error and display it to the user
    } catch (error) {
      Message.flutterToast(context, error.toString());
    }
  }

  @override
  passwordReset(BuildContext context, String email) {
    // TODO: implement passwordReset
    throw UnimplementedError();
  }

  @override
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
