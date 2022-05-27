import 'package:ezka_interview/screens/search/results/models/search_model.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  final String name;
  final String lastname;
  final String address;

  const ResultsScreen(
      {Key? key,
      required this.name,
      required this.lastname,
      required this.address})
      : super(key: key);
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results")),
      body: SearchModel(
          name: widget.name,
          lastname: widget.lastname,
          address: widget.address),
    );
  }
}
