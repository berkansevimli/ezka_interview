import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezka_interview/constants.dart';
import 'package:ezka_interview/screens/messages/Screens/fetch_receiver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchModel extends StatelessWidget {
  final String name;
  final String lastname;
  final String address;

  const SearchModel(
      {Key? key,
      required this.name,
      required this.lastname,
      required this.address})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('Users')
        .where("firstname", isEqualTo: name)
        .where("lastname", isEqualTo: lastname)
        .where("address", isEqualTo: address)
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
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48.0,
                ),
                child: Lottie.asset("assets/lotties/empty.json"),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "No Result",
                style: TextStyle(fontSize: 20),
              )
            ],
          ));
        }

        return ListView(
          physics: BouncingScrollPhysics(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            return ListTile(
              title: Text(data['firstname'] + ' ' + data['lastname']),
              subtitle: Text(data['address']),
              trailing: TextButton.icon(
                  onPressed: () {
                    print(data['uid']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                FetchReceiverInfos(receiverID: data['uid'])));
                  },
                  icon: Icon(CupertinoIcons.chat_bubble_2),
                  label: Text('Message')),
            );
          }).toList(),
        );
      },
    );
  }
}
