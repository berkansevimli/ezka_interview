import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../profile_screen/model/MyUser.dart';
import 'chat_screen.dart';

class FetchReceiverInfos extends StatefulWidget {
  final String receiverID;

  const FetchReceiverInfos({
    Key? key,
    required this.receiverID,
  }) : super(key: key);
  @override
  _FetchReceiverInfosState createState() => _FetchReceiverInfosState();
}

class _FetchReceiverInfosState extends State<FetchReceiverInfos> {
  CollectionReference mRef = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: mRef.doc(widget.receiverID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            MyUser user = MyUser(
              uid: widget.receiverID,
              firstname: data['firstname'],
              lastname: data['lastname'],
              img: data['img'],
              //blocks: data['blocks'],
            );

            return ChatPage(
              user: user,
            );
          }

          return Center(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: SizeConfig.screenWidth / 6,
                    width: SizeConfig.screenWidth / 6,
                    child: SvgPicture.asset(
                      "assets/icons/studeed_logo.svg",
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  height: 32,
                ),
                CircularProgressIndicator()
              ],
            )),
          );
        },
      ),
    );
  }
}
