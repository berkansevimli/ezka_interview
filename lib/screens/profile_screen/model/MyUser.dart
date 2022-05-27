import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUser {
  final String? address;
  final String? bio;
  final String? email;
  final String? firstname;
  final String? img;
  final String? lastname;
  final String? phoneNumber;
  final String? uid;
  final DateTime? join_date;

  MyUser({
    this.address,
    this.img,
    this.join_date,
    this.lastname,
    this.phoneNumber,
    this.uid,
    this.email,
    this.firstname,
    this.bio,
  });
}
