import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  String? imageUrl;

  getImageUrl() async {
    log(imageUrl.toString());
    await FirebaseDatabase.instance
        .reference()
        .child('userInfo')
        .child(currentUser!.uid)
        .once()
        .then((dataSnapshot) {
      imageUrl = dataSnapshot.value['imageUrl'].toString();
      log(dataSnapshot.value['imageUrl'].toString());
      setState(() {});
    });
  }

  @override
  void initState() {
    getImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: imageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl.toString()),
                      radius: 50,
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/man.gif',
                      ),
                      radius: 50,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
