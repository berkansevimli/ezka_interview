import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  final int? followers;

  final int? follows;

  final int? checkins;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");

  NumbersWidget(
      {Key? key,
      r,
      required this.followers,
      required this.follows,
      required this.checkins})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getNumbers();
  }

  Widget buildDivider() => Container(
      height: 24,
      child: VerticalDivider(
        
      ));

  Widget buildButton(String value, String text) => MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, ),
            ),
            Text(
              text,
              style: TextStyle(),
            )
          ],
        ),
      );

  getNumbers() {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(checkins.toString(), 'Event'),
                buildButton(followers.toString(), 'Deed'),
                buildButton(follows.toString(), 'Likes'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
