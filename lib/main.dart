import 'package:ezka_interview/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AuthScreens/wrapper.dart';
import 'Provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Container();
          } else if (snapshot.hasData) {
            
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<MyProvider>.value(value: MyProvider()),
                StreamProvider<User?>.value(
                    value: MyProvider().user, initialData: null)
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
                theme: lightTheme(),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

