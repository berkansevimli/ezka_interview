import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezka_interview/screens/messages/models/ChatMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/message.dart';


class FetchMessages extends StatefulWidget {
  final String receiverID;
  final String userIMG;

  const FetchMessages(
      {Key? key, required this.receiverID, required this.userIMG})
      : super(key: key);
  @override
  _FetchMessagesState createState() => _FetchMessagesState();
}

class _FetchMessagesState extends State<FetchMessages> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String userID = firebaseAuth.currentUser!.uid;

    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('Chats')
        .doc(userID)
        .collection('chats')
        .doc(widget.receiverID)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Mesaj Yok'));
        }

        return ListView(
          
          physics: BouncingScrollPhysics(),
          reverse: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            bool isSender = data['from'] == userID;
            String type = data['type'];
            String mediaURL = data['media'];

            ChatMessage message = ChatMessage(
                text: data['message'],
                messageType: type,
                isSender: isSender,
                mediaUrl: data['media'],
                messageTime: data['time'].toDate()
                );

            return Message(
              message: message,
              userIMG: widget.userIMG,
            );
       
          }).toList(),
        );
      },
    );
  }

  




}
