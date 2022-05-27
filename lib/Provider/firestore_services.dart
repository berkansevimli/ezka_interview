import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FirestoreServices with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");

  ///Add User
  Future<void> userSetup(DateTime time, String email) async {


    String _uid = firebaseAuth.currentUser!.uid.toString();

    
    userRef.doc(_uid).set({
      'uid': _uid,
      'join_date': time,
      'email': email,
      'img': 'default',
      'bio': 'default',
      'name': 'default',
      'firstname': 'default',
      'lastname': 'default',
      'address': 'default',
      'phoneNumber': 'default'

    });


    return;
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  ///Update User
  Future<void> updateUser(String _uid, String firstname, String lastname,
      String address, String phoneNumber) {
    return userRef
        .doc(_uid)
        .update({
          'firstname': firstname,
          'lastname': lastname,
          'address': address,
          'phoneNumber': phoneNumber
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }


    ///Update Profile
  Future<void> updateProfile(String _uid, String img) {
    return userRef
        .doc(_uid)
        .update({
          'img': img,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
