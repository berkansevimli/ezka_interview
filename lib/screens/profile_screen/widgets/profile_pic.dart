import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezka_interview/Provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../constants.dart';

import '../model/fetch_datas.dart';

class ProfilePic extends StatefulWidget {
  final String img;
  final bool isProfile;
  final bool isSettings;
  final String? categoryCode;

  const ProfilePic({
    Key? key,
    required this.img,
    required this.isProfile,
    required this.isSettings,
    this.categoryCode,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          widget.img == "default"
           ? Image.asset(
                      "assets/icons/user.png",
                      color: kPrimaryColor,
                    )
                  
              : ClipOval(
                  child: CachedNetworkImage(
                      imageUrl: widget.img, fit: BoxFit.cover),
                ),
          widget.isSettings
              ? Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                      },
                      child: Icon(
                        Icons.add,
                        color: kCardColor,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
