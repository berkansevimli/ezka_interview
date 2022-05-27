import 'package:ezka_interview/screens/map/current_location.dart';
import 'package:ezka_interview/screens/profile_screen/model/fetch_datas.dart';
import 'package:ezka_interview/screens/search/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../enums.dart';
import '../screens/home_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth;

    final Color inActiveIconColor = Color(0xFFB6B6B6);
    firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser!.uid;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.home,
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => HomeScreen()),
                        (route) => false);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: MenuState.search == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SearchScreen()),
                        (route) => false);
                  }),
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: MenuState.map == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CurrentLocationScreen()),
                      (route) => false);
                },
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => GetUserInfos(
                                  userID: uid,
                                )),
                        (route) => false);
                  }),
            ],
          )),
    );
  }
}
