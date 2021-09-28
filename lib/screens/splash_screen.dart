import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log('hello world');
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen(),
          ),
        );
      });
      return;
    }

    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[150],
                  border: Border.all(color: Colors.black)),
              child: Hero(
                tag: 'girl1',
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 120,
                  child: Image.asset('assets/images/girl1.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Shop App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
