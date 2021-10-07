// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Text('Search the News'),
            // ignore: avoid_unnecessary_containers
            Container(
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  hintText: "Search........",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
