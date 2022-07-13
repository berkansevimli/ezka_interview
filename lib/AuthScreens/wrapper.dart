
import 'package:ezka_interview/AuthScreens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../size_config.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<User?>(context);
    if (user != null) {
      return HomeScreen();
    } else {
      return SignInScreen();
    }
  }
}
