import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezka_interview/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/profile_screen/model/MyUser.dart';


showLoadingDialog(BuildContext context, String message) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) => CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
            content: LinearProgressIndicator(),
          ));
}

showErrorDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                height: 48,
                width: 48,
                child: SvgPicture.asset(
                  "assets/icons/Error.svg",
                ),
              ),
            ),
            content: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
}

showOnlySuccess(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SvgPicture.asset(
                "assets/icons/Success.svg",
                color: Colors.green,
              ),
            ), 
            content:Text(message, style: TextStyle(fontSize: 18),),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
}

showSuccessDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
            title: Text("Successfully completed!"),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SvgPicture.asset(
                "assets/icons/Success.svg",
                color: Colors.green,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("Back to Home"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                      (route) => false);
                },
              )
            ],
          ));
}

showConfirmationDialog(BuildContext context, String message, String uniID,
    String sessionID, String uid, bool approve, bool isDelete, bool isOne) {
  isDelete
      ? showDialog(
          context: context,
          builder: (builder) => CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Are you sure?"),
            ),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('universities')
                      .doc(uniID)
                      .collection('sessions')
                      .doc(sessionID)
                      .collection('members')
                      .doc(uid)
                      .delete();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
      : showDialog(
          context: context,
          builder: (builder) => CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Are you sure?"),
            ),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('universities')
                      .doc(uniID)
                      .collection('sessions')
                      .doc(sessionID)
                      .collection('members')
                      .doc(uid)
                      .update({'approved': approve}).then((value) {
                    approve && isOne
                        ? FirebaseFirestore.instance
                            .collection('universities')
                            .doc(uniID)
                            .collection('sessions')
                            .doc(sessionID)
                            .collection('members')
                            .where('approved', isEqualTo: false)
                            .get()
                            .then((value) {
                            value.docs.forEach((element) async {
                              await FirebaseFirestore.instance
                                  .collection('universities')
                                  .doc(uniID)
                                  .collection('sessions')
                                  .doc(sessionID)
                                  .collection('members')
                                  .doc(element.id)
                                  .delete();
                            });
                          })
                        : print('okay');
                  });

                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(uid)
                      .collection('sessions')
                      .doc(sessionID)
                      .update({'approved': approve});

                  approve
                      ? FirebaseFirestore.instance
                          .collection('universities')
                          .doc(uniID)
                          .collection('sessions')
                          .doc(sessionID)
                          .update({'members.$uid': 0}).then((value) => {
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(uid)
                                    .collection('sessions')
                                    .doc(sessionID)
                                    .update({'status': 0})
                              })
                      : FirebaseFirestore.instance
                          .collection('universities')
                          .doc(uniID)
                          .collection('sessions')
                          .doc(sessionID)
                          .update({'members.$uid': 3}).then((value) => {
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(uid)
                                    .collection('sessions')
                                    .doc(sessionID)
                                    .update({'status': 3})
                              });

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
}

showSuccesAndReturnDialog(BuildContext context, String message, MyUser user) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) => CupertinoAlertDialog(
            title: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text('Back Home'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomeScreen()),
                      (route) => false);
                },
              )
            ],
          ));
}

showApproveDialog(BuildContext context, List actions, String title,
    String subtitle, VoidCallback onAccept) {
  showDialog(
      context: context,
      builder: (builder) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                child: Text(actions[0]),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(actions[1]),
                onPressed: onAccept,
              )
            ],
          ));
}
