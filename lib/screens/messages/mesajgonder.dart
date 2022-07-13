import 'package:ezka_interview/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mesajgonder1 extends StatefulWidget {
  const Mesajgonder1({Key? key}) : super(key: key);

  @override
  State<Mesajgonder1> createState() => _Mesajgonder1State();
}

class _Mesajgonder1State extends State<Mesajgonder1> {


  List message = [];
  List senderReciever = [];
  int counter = 0;
  String? docId;
  String isim = "";

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final TextEditingController _textController = TextEditingController();
  var firebaseUser = FirebaseAuth.instance.currentUser!.uid;
  var firebaseUser2 = "gEVhzrQKxnbBPHEqLZufR43Vgiv1";

  _fetchData() async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc('gEVhzrQKxnbBPHEqLZufR43Vgiv1')
        .get()
        .then((value) {
      setState(() {
        isim = value.data()!["userName"] + " " + value.data()!["userSurname"];
      });
      print(isim);
    });
  }

  Future<void> _onUser() async {
    int index = 0;
    await FirebaseFirestore.instance
        .collection("Chats")
        .get()
        .then((querySnapshot) {
      {
        for (var result in querySnapshot.docs) {
          setState(() {
            docId = result.id;
          });

          if (result.data()['member1'] == firebaseUser &&
                  result.data()['member2'] == firebaseUser2 ||
              result.data()['member2'] == firebaseUser &&
                  result.data()['member1'] == firebaseUser2) {
            for (index = 0; index < result.data()['count']; index++) {
              message.add(result.data()["messages"][index]["message"]);
              senderReciever.add(result.data()["messages"][index]["type"]);
            }
          }
        }
      }
    });

    print(message);
    print(senderReciever);
    print(docId);
    setState(() {
      counter = message.length;
    });
  }

  Future<void> _onAdd() async {
    int index = 0;
    await FirebaseFirestore.instance
        .collection("Chats")
        .get()
        .then((querySnapshot) {
      {
        for (var result in querySnapshot.docs) {
          message.add(result.data()["messages"][counter]["message"]);
          senderReciever.add(result.data()["messages"][counter]["type"]);
        }
      }
    });
    setState(() {
      counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _onUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //bottomNavigationBar: BottomNavBar2(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //const ArkaPlan(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                const Image(image: AssetImage("assets/images/logo.png")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.12,
                      child: const Image(
                          image: AssetImage("assets/images/profile.png")),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
                      child: Text(
                        isim,
                        style: const TextStyle(
                            fontSize: 17, color: Color(0xffFFFFFF)),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
                              child: const Text(
                                "14/06/1989",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xffFFFFFF)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xffFFFFFF)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
                              child: const Text(
                                "22.39",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xffFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(
                    thickness: SizeConfig.screenHeight * 0.002,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffb707070),
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black45),
                        height: SizeConfig.screenHeight * 0.48,
                        child: ListView.builder(
                          itemCount: counter,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              //height: SizeConfig.screenHeight * 0.15,
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              child: Align(
                                alignment: ((senderReciever[index] == "sender"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: (senderReciever[index] == "sender"
                                        ? Colors.white
                                        : const Color(0xffEC255A)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    message[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            ((senderReciever[index] == "sender"
                                                ? Colors.black
                                                : Colors.white))),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.015,
                      ),
                      Align(
                        alignment: const Alignment(0, 0.5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.white),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _textController,
                                  decoration: const InputDecoration(
                                      hintText: "Mesaj yaz...",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  FirebaseFirestore.instance
                                      .collection('Chats')
                                      .doc(docId)
                                      .set({
                                    "count": FieldValue.increment(1),
                                    "messages": FieldValue.arrayUnion([
                                      {
                                        "message": _textController.text,
                                        "type": "reciever"
                                      }
                                    ])
                                  }, SetOptions(merge: true));
                                  await _onAdd();
                                  _textController.text = "";
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 5, right: 10),
                                  child: const Text(
                                    "Gönder",
                                    style: TextStyle(
                                        color: Color(0xffEC255A),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )

                //TODO
                // StreamBuilder<QuerySnapshot>(
                // stream: FirebaseFirestore.instance.collection("Posts").orderBy(
                //  "Creation Time", descending: true).snapshots(),
                // builder: (context, snapshot) {
                //   if (snapshot.connectionState == ConnectionState.waiting) {
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else return
              ],
            ),
          ),
        ],
      ),
    );
  }
}
