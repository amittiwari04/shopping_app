// import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/modals/user_info.dart';
import 'package:shopping_app/screens/home_screen.dart';

import 'package:shopping_app/services/database.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? imageUrl;
  String? phoneNumber;

  // String? path;
  var _imageFile;

  bool _isLoading = false;

  final ImagePicker picker = ImagePicker();

  // pickImageFromCamera() async {
  //   log('camera');
  //   List<Media>? res = await ImagesPicker.openCamera(
  //     pickType: PickType.image,
  //     cropOpt: CropOption(
  //       // aspectRatio: CropAspectRatio.wh16x9,
  //       cropType: CropType.circle,
  //     ),
  //     quality: 0.5,
  //   );

  //   if (res != null) {
  //      log('camera');
  //     print(res[0].path);
  //     setState(() {
  //       path = res[0].path;
  //     });
  //   }else{
  //      log('camera no');
  //   }
  // }

  // Future pickImageFromGallery() async {
  //   List<Media>? res = await ImagesPicker.pick(
  //     pickType: PickType.image,
  //     count: 1,
  //     cropOpt: CropOption(
  //       // aspectRatio: CropAspectRatio.wh16x9,
  //       cropType: CropType.circle,
  //     ),
  //     quality: 0.5,
  //   );

  //   if (res != null) {
  //     print(res[0].path);
  //     setState(() {
  //       path = res[0].path;
  //     });
  //   }
  // }

  Future pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    log(_imageFile.runtimeType.toString());
    setState(() {
      _imageFile = new File(pickedFile!.path);
    });
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    log(_imageFile.runtimeType.toString());
    setState(() {
      _imageFile = new File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading == false
          ? Container(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          _imageFile != null
                              ? CircleAvatar(
                                  radius: height * 0.1,
                                  backgroundImage: FileImage(_imageFile),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    //  await pickImageFromCamera();
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: height * 0.009,
                                              ),
                                              Text(
                                                'Profile Photo',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_camera),
                                                title: Text('Camera'),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  pickImageFromCamera();
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.photo),
                                                title: Text('Gallery'),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  pickImageFromGallery();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: height * 0.1,
                                    backgroundImage: AssetImage(
                                      'assets/images/man.gif',
                                    ),
                                  ),
                                ),
                          // CircleAvatar(
                          //   // backgroundColor: Colors.white,
                          //   radius: height * 0.1,
                          //   child: _imageFile != null
                          //       ? Image.file(_imageFile!)
                          //       : Image.asset(
                          //           'assets/images/camera.jpg',
                          //           height: height * 0.12,
                          //           fit: BoxFit.cover,
                          //         ),
                          // ),
                          Positioned(
                            bottom: height * 0.01,
                            right: width * 0.26,
                            child: GestureDetector(
                              onTap: () async {
                                //  await pickImageFromCamera();
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          Text(
                                            'Profile Photo',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.photo_camera),
                                            title: Text('Camera'),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              await pickImageFromCamera();
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.photo),
                                            title: Text('Gallery'),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              await pickImageFromGallery();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pink,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: width * 0.07,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.trim() == '') {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          name = val;
                        },
                        decoration: InputDecoration(
                          suffixText: '*',
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          // fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.pink,
                              width: 2,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Enter your name',
                          labelText: 'Name *',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.trim() == '') {
                            return 'Please enter your Phone Number.';
                          } else if (val.length != 10) {
                            return 'Phone Number must be of length 10';
                          } else {
                            final isDigitOnly = int.tryParse(val);
                            if (isDigitOnly == null) {
                              return 'Phone number must be digits only';
                            }
                          }
                          return null;
                        },
                        onChanged: (val) {
                          phoneNumber = val;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          suffixText: '*',
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
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.pink,
                              width: 2,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Enter your Phone Number',
                          labelText: 'Phone Number *',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.28,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_imageFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please upload your profile picture.'),
                                ),
                              );
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              log('1');
                              String profilePicUrl = await DatabaseMethods()
                                  .uploadImageToFirebase(context, _imageFile);
                              log('2');
                              User? currentUser =
                                  FirebaseAuth.instance.currentUser;
                              UserInformation userInfo = UserInformation(
                                email: currentUser!.email,
                                phoneNumber: phoneNumber,
                                name: name,
                                imageUrl: profilePicUrl,
                              );
                              log('3');
                              await DatabaseMethods()
                                  .uploadUserInfo(userInfo)
                                  .then((value) {
                                log('4');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                                log('5');
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Submit',
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
