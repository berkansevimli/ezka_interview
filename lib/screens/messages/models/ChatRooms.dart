import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../profile_screen/widgets/profile_pic.dart';
import '../Screens/fetch_receiver.dart';


class GetChatRooms extends StatefulWidget {
  final Timestamp? time;
  final String? receiverID;
  final String? lastMessage;
  const GetChatRooms({Key? key, this.time, this.receiverID, this.lastMessage})
      : super(key: key);

  factory GetChatRooms.fromDocument(DocumentSnapshot documentSnapshot) {
    return GetChatRooms(
      time: documentSnapshot['time'],
      receiverID: documentSnapshot.id,
      lastMessage: documentSnapshot['lastMessage'],
    );
  }

  @override
  _GetChatRoomsState createState() => _GetChatRoomsState(
      time: this.time,
      receiverID: this.receiverID,
      lastMessage: this.lastMessage);
}

class _GetChatRoomsState extends State<GetChatRooms> {
  CollectionReference userRef = FirebaseFirestore.instance.collection("Users");


  final String? receiverID;
  final String? lastMessage;
  final Timestamp? time;

  var countPos;
  bool isLoading = false;

  List<double> prices = [];
  bool isLoading2 = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  _GetChatRoomsState({
    this.time,
    this.receiverID,
    this.lastMessage,
  });
  /*  */

  @override
  Widget build(BuildContext context) {
    String uid = firebaseAuth.currentUser!.uid;
    return StreamBuilder<DocumentSnapshot>(
      stream: userRef.doc(receiverID).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListTile(
          leading: Hero(
            tag: 'heeye',
            child: Container(
                height: 32.0,
                width: 32.0,
                child: ProfilePic(
                  isProfile: true,
                  isSettings: false,
                  img: snapshot.data!.get('img'),
                )),
          ),
          title: Text(snapshot.data!.get('username')),
          subtitle: Text(lastMessage!),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) =>
                    FetchReceiverInfos(receiverID: receiverID!)));
          },
        );
      },
    );
  }
}

// return Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: InkWell(
//     onTap: () {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => ProductDetails(
//                     docID: docID,
//                   )));
//     },
//     child: Row(
//       children: [
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: screenWidth / 2,
//               child: Text(
//                 docID!,
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text.rich(
//               TextSpan(
//                 text: double.parse(count.toString()).toStringAsFixed(2) +
//                     " TL",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, color: kPrimaryColor),
//               ),
//             ),
//             //IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.trash))
//           ],
//         ),
//         Spacer(),
//       ],
//     ),
//   ),
// );
// return ListTile(
//   title: Text(
//     title!,
//     style: TextStyle(color: Colors.black, fontSize: 16),
//   ),
//   subtitle: Text.rich(
//     TextSpan(
//       text: price! + " TL",
//       style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryColor),
//     ),
//   ),
//   trailing: IconBtnWithCounter(
//     svgSrc: "assets/icons/Cart Icon.svg",
//     press: () {},
//   ),
//   leading: Container(
//     height: 64,
//     width: 64,
//     child: CachedNetworkImage(
//       imageUrl: img!,
//       placeholder: (context, url) => Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: new Image.asset('assets/icons/loading.gif'),
//       ),
//       errorWidget: (context, url, error) => new Icon(Icons.error),
//     ),
//   ),
// );
