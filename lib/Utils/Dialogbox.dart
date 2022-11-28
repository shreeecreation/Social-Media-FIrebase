import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/ImageUpload/image.dart';
import 'package:firebase_authentication/Login/login_screen.dart';
import 'package:firebase_authentication/UserPage/All%20Post/bloc/private_bloc.dart';
import 'package:firebase_authentication/UserPage/Viewphoto/viewphoto.dart';
import 'package:firebase_authentication/UserPage/user_screen.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../UserPage/All Post/bloc/post_bloc.dart';

class ShowDialog {
  static Future<void> showMyDialog(var context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error !', style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> userCreateDialog(var context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Register Success ', style: TextStyle(fontWeight: FontWeight.w400)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => const Login())), (route) => false);
                Auth.signOut(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> uploadPhotoDialog(var context, String photolink, String caption) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profile Picture", style: TextStyle(fontWeight: FontWeight.w400)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ViewPhotos(
                                    photolink: photolink,
                                    caption: caption,
                                  )));
                    },
                    child: const Text("View Profile Picture")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ImageUploads()));
                    },
                    child: const Text("Upload Profile Picture")),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: const <Widget>[],
        );
      },
    );
  }

  static Future<void> askingUploadPhoto(var context, var image, void Function() yes) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Warning",
            style: TextStyle(color: Colors.yellow),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[Text("Upload Photo ??")],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: yes,
              child: const Text("Yes"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }

  static Future<void> backtoHomeAfterUpload(var context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Photo Uploaded", style: TextStyle(fontWeight: FontWeight.w400)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Successfully Uploaded"),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const UserPage()), (route) => false);
                  context.read<PostBloc>().add(Postfetchevent());
                  context.read<PrivateBloc>().add(PostLoadingPrivate());
                },
                child: const Text("Ok")),
          ],
        );
      },
    );
  }

  static Future<void> logOut(var context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.yellow)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  "Do you sure want to log out ?",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const Login()), (route) => false);
                  context.read<PostBloc>().add(Postfetchevent());
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
          ],
        );
      },
    );
  }

  static Future<bool> onBackButtonPressed(BuildContext context) async {
    bool? exitapp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Warning",
              style: TextStyle(color: Colors.yellow),
            ),
            content: const Text("Exiting Upload ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Yes")),
            ],
          );
        });
    return exitapp ?? false;
  }

  static Future<void> loadingPhoto(var context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "",
            style: TextStyle(color: Colors.yellow),
          ),
          content: SizedBox(
            height: 80,
            width: 100,
            child: Column(
              children: const [Text("Uploading"), SizedBox(height: 20), CircularProgressIndicator()],
            ),
          ),
          actions: const <Widget>[],
        );
      },
    );
  }
}
