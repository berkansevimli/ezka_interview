import 'package:flutter/material.dart';

import 'components/body.dart';

class ComplateProfileScreen extends StatefulWidget {
  final String uid;
  ComplateProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ComplateProfileScreenState createState() => _ComplateProfileScreenState();
}

class _ComplateProfileScreenState extends State<ComplateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(uid: widget.uid,),
    );
  }
}
