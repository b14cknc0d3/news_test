// ignore_for_file: deprecated_member_use, duplicate_ignore, prefer_typing_uninitialized_variables
import 'package:ansar_news/main.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // Intense Area
    final TextEditingController name = TextEditingController(text: "hadiqa");
    final TextEditingController email =
        TextEditingController(text: "hadiqa@gmail.com");
    final TextEditingController password =
        TextEditingController(text: "123456");

    // Login Function
    // ignore: unused_element

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String susername = email.text;
      // ignore: unused_local_variable
      final String sname = name.text;
      final String spass = password.text;
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: susername, password: spass);
        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        // ignore: unused_local_variable
        final data = snapshot.data();
        // ignore: avoid_print
        print("User is Logged in ");
        Loading();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyNewsApp()));
      } catch (e) {
        // ignore: avoid_print

        showDialog(
            context: context,
            builder: (BuildContext context) {
              // ignore: unused_local_variable
              final message;
              return AlertDialog(content: Text("User Not Valid"));
            });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.redAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: duplicate_ignore
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                    width: 400,
                    height: 300,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                // ignore: todo
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.redAccent[700], fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.redAccent[700],
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent[700]),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text("New User? Create Account")),
          ],
        ),
      ),
    );
  }
}
