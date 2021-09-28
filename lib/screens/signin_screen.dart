import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/on_boarding.dart';
import 'package:shopping_app/screens/register_screen.dart';
import 'package:shopping_app/services/auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  bool _isVisible = false;
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading == false
          ? SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      height: height * 0.3,
                      width: width,
                      child: PageView(
                        controller: _pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Hero(
                            tag: 'girl1',
                            child: Container(
                              height: height * 0.35,
                              width: width,
                              child: Image.asset('assets/images/girl1.png'),
                            ),
                          ),
                          Container(
                            height: height * 0.35,
                            width: width,
                            child: Image.asset('assets/images/sale.png'),
                          ),
                          Container(
                            height: height * 0.35,
                            width: width,
                            child: Image.asset('assets/images/couple1.jpg'),
                          ),
                          Container(
                            height: height * 0.35,
                            width: width,
                            child: Image.asset('assets/images/cart.jpg'),
                          ),
                          Container(
                            height: height * 0.35,
                            width: width,
                            child: Image.asset('assets/images/cart_debit.jpg'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: height * 0.42,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange[300],
                        // color: Colors.pink,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: ListView(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val == null || val.trim() == '') {
                                    return 'Please enter your email.';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  email = val;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'you@example.com',
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Stack(
                                children: [
                                  TextFormField(
                                    validator: (val) {
                                      if (val == null || val.trim() == '') {
                                        return 'Please enter your password.';
                                      } else if (val.length < 6) {
                                        return 'Password must be atleast 6 characters.';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      password = val;
                                    },
                                    obscureText: _isVisible == false,
                                    decoration: InputDecoration(
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'password',
                                      labelText: 'password',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // ),
                                  Positioned(
                                    right: width * 0.06,
                                    top: 14,
                                    child: InkWell(
                                      child: _isVisible
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                      onTap: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: TextFormField(
                              //         obscureText: _isVisible == false,
                              //         decoration: InputDecoration(
                              //           fillColor: Colors.white,
                              //           focusedBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(25),
                              //             borderSide: BorderSide(color: Colors.white),
                              //           ),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(25),
                              //             borderSide: BorderSide(
                              //               color: Colors.black,
                              //               width: 2,
                              //             ),
                              //           ),
                              //           border: InputBorder.none,
                              //           hintText: 'password',
                              //           labelText: 'password',
                              //           labelStyle: TextStyle(
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     InkWell(
                              //       child: _isVisible
                              //           ? Icon(Icons.visibility)
                              //           : Icon(Icons.visibility_off),
                              //       onTap: () {
                              //         setState(() {
                              //           _isVisible = !_isVisible;
                              //         });
                              //       },
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await AuthMethods().signIn(email, password);

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'LogIn',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        await AuthMethods()
                            .signInWIthGoogle()
                            .then((value) async {
                          User? currentUser = FirebaseAuth.instance.currentUser;
                          final DataSnapshot dataSnapshot =
                              await FirebaseDatabase.instance
                                  .reference()
                                  .child('userInfo')
                                  .child(currentUser!.uid)
                                  .once();

                          log('hello data snapshot');
                          log(dataSnapshot.value.toString());

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return dataSnapshot.value == null
                                ? OnBoarding()
                                : HomeScreen();
                          }));
                          log('hello data snapshot 123');
                          setState(() {
                            _isLoading = false;
                          });
                          log(_isLoading.toString());
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.31),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        // width: width * 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 45,
                              width: 45,
                              child:
                                  Image.asset('assets/images/google_logo.png'),
                            ),
                            Text(
                              'Google ',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                        ),
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ));
                          },
                          child: Text(
                            'Register here',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
    );
  }
}
