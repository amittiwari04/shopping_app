import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// import 'package:path/path.dart';
import 'package:shopping_app/modals/user_info.dart';

class DatabaseMethods {
  Future uploadImageToFirebase(BuildContext context, File _imageFile) async {
    try {
      // String fileName = basename(_imageFile.path);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        log(currentUser.uid);
      }

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profilePic')
          .child(currentUser!.uid);
      UploadTask uploadTask = storageReference.putFile(_imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      log(e.toString());
    }
  }

  Future uploadUserInfo(UserInformation userInfo) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        log(currentUser.uid);
      }

      await FirebaseDatabase.instance
          .reference()
          .child('userInfo')
          .child(currentUser!.uid)
          .update({
        'email': userInfo.email,
        'phoneNumber': userInfo.phoneNumber,
        'name': userInfo.name,
        'imageUrl': userInfo.imageUrl,
      });
      log('user info uploaded');
    } catch (e) {
      log(e.toString());
    }
  }
}
