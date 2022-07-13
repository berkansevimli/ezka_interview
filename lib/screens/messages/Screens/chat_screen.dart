import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezka_interview/screens/profile_screen/model/fetch_datas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../theme.dart';
import '../../profile_screen/model/MyUser.dart';
import '../Services/message_sender.dart';
import '../models/fetch_messages.dart';
import '../widgets/chat_header.dart';

class ChatPage extends StatefulWidget {
  final MyUser user;
  String messageText;

  ChatPage({
    Key? key,
    this.messageText = "",
    required this.user,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  String? messageText;
  File? file;
  bool isRecorded = false;

  final sender = MessageSender();

  @override
  void initState() {
    super.initState();
    String userID = firebaseAuth.currentUser!.uid;

    _messageController.text = "";
    sender.updateSeen(userID, widget.user.uid!);
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    String userID = firebaseAuth.currentUser!.uid;

    //final Map blocks = widget.user.blocks!;
    //print(blocks);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: false,
          elevation: 0.5,
          shadowColor: Theme.of(context).primaryColor,
          title: ChatHeaderWidget(
            widget: widget,
            buildContext: context,
          ),
          actions: [
            PopupMenuButton(
                color: Theme.of(context).cardColor,
                onSelected: (item) =>
                    onSelected(context, int.parse(item.toString()), userID),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Text('Show Profile'),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text('Block'),
                      ),
                    ]),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FetchMessages(
                receiverID: widget.user.uid!,
                userIMG: widget.user.img!,
              ),
            ),
            Form(
              key: _formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(child: buildMessageFormField()),
                        // IconButton(
                        //     onPressed: () {
                        //       showModalBottomSheet(
                        //           backgroundColor: kCardColor,
                        //           context: context,
                        //           builder: (BuildContext c) {
                        //             return buildBottomSheetMenu(context);
                        //           });
                        //     },
                        //     icon: Icon(Icons.attach_file)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 4),
                          child: FloatingActionButton(
                              mini: true,
                              backgroundColor: kPrimaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _messageController.text = "";
                                  await sender.sendMessage(
                                      context,
                                      widget.user.uid!,
                                      userID,
                                      messageText,
                                      widget.user.firstname! + ' ' + widget.user.lastname!,
                                      widget.user.img!,
                                      "text",
                                      "default",
                                      );
                                }
                              },
                              child: Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void onSelected(BuildContext context, int item, String userID) {
    switch (item) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => GetUserInfos(userID: widget.user.uid!)));
        break;
      case 1:
        // print('object');

        // showApproveDialog(
        //     context,
        //     ['Cancel', 'Block'],
        //     'Are you sure you want to block this user?',
        //     'The user will not be able to send you messages!', () async {
        //   Navigator.pop(context);

        //   await FirebaseFirestore.instance
        //       .collection('Users')
        //       .doc(userID)
        //       .update({'blocks.${widget.user.uid}': true});
        //   showOnlySuccess(context, 'User blocked!');
        // });
        break;
      default:
    }
  }

  buildBottomSheetMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FileMenuWidget(
          text: "Take Photo",
          icon: Icon(
            Icons.photo_camera,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
            sender.sendPhotoMessage(
                context,
                widget.user.uid!,
                messageText == null ? "" : "",
                widget.user.firstname! + ' ' + widget.user.lastname!,
                widget.user.img!,
                false,
                );
          },
        ),
        FileMenuWidget(
          text: "Select Photo",
          onTap: () {
            Navigator.pop(context);
            sender.sendPhotoMessage(
                context,
                widget.user.uid!,
                messageText == null ? "" : "",
                widget.user.firstname! + ' ' + widget.user.lastname!,
                widget.user.img!,
                true,
                );
          },
          icon: Icon(
            Icons.photo_library,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 32,
        )
      ],
    );
  }

  TextFormField buildMessageFormField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      maxLines: 4,
      minLines: 1,
      controller: _messageController,
      style: TextStyle(fontSize: 16),
      onSaved: (newValue) => messageText = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Message feel can not be empty!");
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Message feel can not be empty!");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Type message...",
        label: Text("Message"),
        suffixIcon: InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: kCardColor,
                  context: context,
                  builder: (BuildContext c) {
                    return buildBottomSheetMenu(context);
                  });
            },
            child: Icon(Icons.photo_camera)),
        hintStyle: TextStyle(fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class FileMenuWidget extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Icon icon;
  const FileMenuWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: onTap,
          title: Text(
            text,
            style: TextStyle(color: kTextColor),
          ),
          leading: icon),
    );
  }
}
