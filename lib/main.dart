// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ansar_news/home_page.dart';
import 'package:ansar_news/login_page.dart';
import 'package:ansar_news/profile_page.dart';
import 'package:sizer/sizer.dart';
import 'favourites_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  bool _initialized = false;
  bool _error = false;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    if (_error) {
      return Error();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }
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
              icon: Icon(Icons.home),
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

// ignore: use_key_in_widget_constructors
class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: avoid_unnecessary_containers
        body: Container(
      child: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: 400,
            height: 300,
            child: Image.asset('assets/images/logo.png'),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
              child: CircularProgressIndicator(
            color: Colors.redAccent[700],
          )),
          // ignore: avoid_unnecessary_containers
          Container(
              child: Text(
            "Ansari News Is Loading",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    ));
  }
}
