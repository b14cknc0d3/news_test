// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Loading Name";
  String email = "Loading Email";
  // Fetch and Show Data
  void getData() async {
    // ignore: unused_local_variable
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance.collection("users").doc().get();
    setState(() {
      name = vari.data()!['name'];
      email = vari.data()!['email'];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("wuers").snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Container(
                      child: SafeArea(
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("image"),
                        )),
                      ),
                      // This CirCal Image Area
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("image"),
                            radius: 60.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Text(name,
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueGrey,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(email,
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueGrey,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      colors: [Colors.pink, Colors.redAccent]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 100.0,
                                    maxHeight: 40.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ]),
                  ));
                },
              );
      },
    ));
  }
}
