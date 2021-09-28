import 'package:flutter/material.dart';
import 'package:shopping_app/screens/profile_screen.dart';
import 'package:shopping_app/screens/signin_screen.dart';
import 'package:shopping_app/services/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }));
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: height * 0.03,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
              Text(
                'My Cart',
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
              Text(
                'Favorites',
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
              Text(
                'My Orders',
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.037,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_outlined),
          ),
          IconButton(
            onPressed: () async {
              AuthMethods().signOut().then((val) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
