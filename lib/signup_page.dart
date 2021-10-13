// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors

// ignore: camel_case_types

// ignore: use_key_in_widget_constructors
class SignUpPage extends StatefulWidget {
  static String tag = 'signup-page';
  Stream collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  // ignore: unnecessary_new
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    // this Is Auth Area
    final TextEditingController namee = TextEditingController();
    final TextEditingController emaile = TextEditingController();
    final TextEditingController passworde = TextEditingController();

    void rregister() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final String sname = namee.text;
      final String susername = emaile.text;
      final String spass = passworde.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: susername, password: spass);
        await db.collection("users").doc(user.user!.uid).set({
          "Email": susername,
          "Name": sname,
        });

        // ignore: avoid_print
        print("User is Registered ");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } catch (e) {
        // ignore: avoid_print
        print("ERROR");
      }
    }

    final name = TextFormField(
      controller: namee,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        icon: Icon(Icons.person, color: Colors.redAccent[700]),
        labelText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final email = TextFormField(
      controller: emaile,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        icon: Icon(Icons.mail, color: Colors.redAccent[700]),
        labelText: 'Email ID',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      controller: passworde,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock, color: Colors.redAccent[700]),
        labelText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
            rregister();
          },
          padding: EdgeInsets.all(12),
          color: Colors.redAccent[700],
          child: Text('Sign Up', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    Container(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.redAccent[700],
          size: 25.0,
        ),
        onPressed: () {},
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.redAccent[700],
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                        // rregister();
                      },
                    ),
                  ),
                  SizedBox(width: 0.0),
                  Text(
                    'Register',
                    style:
                        TextStyle(color: Colors.redAccent[700], fontSize: 20.0),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                children: <Widget>[
                  SizedBox(height: 24.0),
                  name,
                  SizedBox(height: 12.0),
                  email,
                  SizedBox(height: 12.0),
                  password,
                  SizedBox(height: 12.0),
                  loginButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
