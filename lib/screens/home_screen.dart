import 'package:ezka_interview/components/coustom_bottom_nav_bar.dart';
import 'package:ezka_interview/enums.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Lottie.asset("assets/lotties/hello.json"),
      )),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
