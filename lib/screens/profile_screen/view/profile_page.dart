import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../components/coustom_bottom_nav_bar.dart';
import '../../../../enums.dart';
import '../../../size_config.dart';
import '../model/MyUser.dart';
import '../widgets/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  final MyUser myUser;

  const ProfilePage({Key? key, required this.myUser}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? followers;

  int? follows;

  int? countPos;
  int? checkins;
  bool isLoading = false;
  bool isLiked = false;
  // List<Posts> post = [];

  bool isLoading2 = false;
  CollectionReference mRef = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    /*  */
    FirebaseAuth mAuth = FirebaseAuth.instance;
    String uid = mAuth.currentUser!.uid;
    bool isCurrent = uid == widget.myUser.uid;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile",
              ),
              elevation: 0.5,
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      buildName(isCurrent),
                      SizedBox(
                        height: 16,
                      ),
                      widget.myUser.bio == 'default'
                          ? SizedBox()
                          : buildAbout(widget.myUser.bio!),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: isCurrent
                ? CustomBottomNavBar(
                    selectedMenu: MenuState.profile,
                  )
                : SizedBox(),
          );
  }

  Widget buildName(bool isCurrent) => ListTile(
      leading: SizedBox(
        height: 64,
        width: 64,
        child: ProfilePic(
          img: widget.myUser.img!,
          isProfile: true,
          isSettings: false,
        ),
      ),
      title: Text(
        widget.myUser.firstname! + ' ' + widget.myUser.lastname!,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Container(
          width: SizeConfig.screenWidth / 2,
          child: Text(
            widget.myUser.address!,
            overflow: TextOverflow.ellipsis,
          )));
}

buildAbout(String bio) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, bottom: 8),
    child: Text(bio),
  );
}
