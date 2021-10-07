import 'package:flutter/material.dart';
import 'package:ansar_news/home_page.dart';
import 'package:ansar_news/login_page.dart';
import 'package:ansar_news/profile_page.dart';
import 'package:sizer/sizer.dart';
import 'favourites_page.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyNewsApp(),
  ));
}

// ignore: use_key_in_widget_constructors
class MyNewsApp extends StatefulWidget {
  @override
  _MyNewsAppState createState() => _MyNewsAppState();
}

class _MyNewsAppState extends State<MyNewsApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(child: pages[currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(
            () => currentIndex = index,
          ),
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favourites",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login_sharp),
              label: "Login",
            ),
          ],
        ),
      );
    });
  }

  int currentIndex = 0;
  final pages = [
    Home(),
    Favourites(),
    Profile(),
    Login(),
  ];
}
