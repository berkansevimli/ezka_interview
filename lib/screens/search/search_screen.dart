import 'package:ezka_interview/components/coustom_bottom_nav_bar.dart';
import 'package:ezka_interview/enums.dart';
import 'package:ezka_interview/screens/search/widgets/search_box.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: ListView(children: [
        Center(
          child: SearchBox(),
        ),
      ]),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.search),
    );
  }
}
