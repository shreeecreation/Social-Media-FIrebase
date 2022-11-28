// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_authentication/UserPage/All%20Post/managecodepost.dart';
import 'package:firebase_authentication/UserPage/Viewphoto/caption.dart';
import 'package:firebase_authentication/Utils/Dialogbox.dart';
import 'package:firebase_authentication/main.dart';
import 'package:flutter/material.dart';

class Auth {
  static String username = "";
  static String profession = "";
  static String photolink = "";

  static var bio;
  static String cap = "";

  static Future signIn(String email, String pass, BuildContext context, var isValid) async {
    if (!isValid) return;
    Foldername.foldername.clear();
    Foldername.foldernamepubilc.clear();
    ManagePrivatePost.photolink.clear();
    ManagePublicPost.photolink.clear();

    showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
      fetchUser();
      fetchUser();
    } on FirebaseAuthException {
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
      ShowDialog.showMyDialog(context, "Incorrect email and password");
    }
  }

  static Future createUser(String email, String pass, var context, var isValid, String username, String profession) async {
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
      ShowDialog.userCreateDialog(context, "Welcome to our family");
      addUserDetails(username, profession, email, pass);
    } on FirebaseAuthException {
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
      ShowDialog.showMyDialog(context, "Incorrect email and password");
    }
  }

  static Future<String?> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future addUserDetails(String username, String profession, String email, String password) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).set({
      'username': username,
      'profession': profession,
      'email': email,
      'password': password,
      'docid': firebaseuser.uid,
      'photo': 'https://cdn.xxl.thumbs.canstockphoto.com/add-photo-thin-line-vector-icon-illustration_csp69336724.jpg',
      'bio': '',
      'caption': '',
    });
  }

  static Future addPhoto(String link, String caption) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).update({'photo': link});
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).update({'caption': caption});
  }

  static Future addCaption(String caption) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).update({'caption': caption});
  }

  static Future addBio(String bio) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).update({'bio': bio});
  }

  static Future fetchUser() async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('basicdetails').doc(firebaseuser.uid).get().then((e) {
      username = e.data()!['username'];
      profession = e.data()!['profession'];
      photolink = e.data()!['photo'];
      bio = e.data()!['bio'] ?? "";
      cap = e.data()!['caption'];
      Caption.caption = cap;
    });
  }

  static Future updateProfile(String bio, String username, String profession) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('basicdetails')
        .doc(firebaseuser.uid)
        .update({'bio': bio, 'username': username, 'profession': profession});
  }

  static Future addPostandBio(String link, String bio) async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('posts').doc(firebaseuser.uid).set({'photo': link});
  }
}
