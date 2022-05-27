
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../view/profile_page.dart';
import 'MyUser.dart';

class GetUserInfos extends StatefulWidget {
  final String userID;

  const GetUserInfos({
    Key? key,
    required this.userID,
  }) : super(key: key);
  @override
  _GetUserInfosState createState() => _GetUserInfosState();
}

class _GetUserInfosState extends State<GetUserInfos> {
  @override
  Widget build(BuildContext context) {
    CollectionReference mRef = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: mRef.doc(widget.userID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget('Something went wrong');
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Scaffold(
                appBar: AppBar(),
                body: SafeArea(
                    child: Center(child: Text("User does not exist"))));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            
            MyUser user = MyUser(
                firstname: data['firstname'],
                lastname: data['lastname'],
                img: data['img'],
                bio: data['bio'],
                email: data['email'],
                address: data['address'],
                uid: widget.userID
                );

            return ProfilePage(
              myUser: user,
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
