import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'firestore_services.dart';


class MyProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
  late String mail;


  Future register(
    String email,
    String password,
    DateTime time,
  ) async {


    setLoading(true);


    try {


      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = authResult.user;


      FirestoreServices().userSetup(time, email);


      setLoading(false);
      return user;

      
    } on SocketException {
      setLoading(false);
      setMessage(
          'Internet bağlantısı bulunamadı, bağlantınızı kontrol edip tekrar deneyin!');
    } catch (e) {
      setLoading(false);

      setMessage(e.toString());
    }

    notifyListeners();


  }

  Future resetPassword(String email) async {
    setLoading(true);
    await firebaseAuth.sendPasswordResetEmail(email: email);
    setLoading(false);
  }

  Future login(String email, String password) async {
    setLoading(true);

    if (isEmail(email)) {
      print('Email ile Giris');
      try {
        UserCredential authResult = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        User? user = authResult.user;
        setLoading(false);
        return user;
      } on SocketException {
        setLoading(false);
        setMessage(
            'Internet bağlantısı bulunamadı, bağlantınızı kontrol edip tekrar deneyin!');
      } catch (e) {
        setLoading(false);

        setMessage(e.toString());
      }
    } else {
      print('Kullanıcı ile Giris');
      usernameLogin(email, password);
    }

    notifyListeners();
  }


  Future updateUser(String _uid, String firstname, String lastname,
      String address, String phoneNumber) async {
    setLoading(true);
    await FirestoreServices()
        .updateUser(_uid, firstname, lastname, address, phoneNumber)
        .then((value) => setLoading(false));
    notifyListeners();
  }

  Future<void> updateProfile(
    String _uid,
    String img,
  ) async {
    setLoading(true);
    await FirestoreServices()
        .updateProfile(_uid, img)
        .then((value) => setLoading(false));
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }


  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }


  Future usernameLogin(String userName, String password) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('Users');

    userRef.where("username", isEqualTo: userName).get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.map((DocumentSnapshot document) async {
          mail = document['email'];
          print(mail);
          try {
            UserCredential authResult = await firebaseAuth
                .signInWithEmailAndPassword(email: mail, password: password);
            User? user = authResult.user;
            setLoading(false);
            return user;
          } on SocketException {
            setLoading(false);
            setMessage(
                'Internet bağlantısı bulunamadı, bağlantınızı kontrol edip tekrar deneyin!');
          } catch (e) {
            setLoading(false);

            setMessage(e.toString());
          }
        }).toList();
      } else {
        setMessage('Kullanıcı  adı bulunamadı');
        setLoading(false);
      }
    });
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);

}



bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
