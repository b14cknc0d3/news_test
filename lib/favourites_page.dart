import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Text('Favourites'),
        ),
      ),
    );
  }
}
