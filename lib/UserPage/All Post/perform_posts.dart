import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Utils/Dialogbox.dart';
import 'package:firebase_authentication/Utils/UserScreen/userdefaultphotolink.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PerformPost extends StatefulWidget {
  const PerformPost({Key? key}) : super(key: key);

  @override
  State<PerformPost> createState() => _PerformPostState();
}

final titlecontroller = TextEditingController();

class _PerformPostState extends State<PerformPost> {
  File? photo;
  bool isuploaded = false;
  Future imgFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {}
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {}
    });
  }

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  var firebaseuser = FirebaseAuth.instance.currentUser!;
  DatabaseReference myRef = FirebaseDatabase.instance.ref(FirebaseAuth.instance.currentUser!.uid);
  double progress = 0;
  List<bool> isSelected = [true, false];
  bool publicornot = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Post "),
          actions: [
            TextButton(
                onPressed: photo != null
                    ? () {
                        uploadImage(titlecontroller.text);
                        titlecontroller.text = "";
                        ShowDialog.loadingPhoto(context);
                      }
                    : null,
                child: const Text("Save"))
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      CircleAvatar(backgroundImage: NetworkImage(PhotoLink.link), radius: 25),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(PhotoLink.username),
                          const SizedBox(height: 3),
                          const Text("Create Post", style: TextStyle(fontSize: 12, color: Colors.white38))
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 3),
                const Text("     What's on your mind ???", style: TextStyle(fontSize: 17, color: Colors.white60)),
                const SizedBox(height: 20),
                photo != null
                    ? Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Image.file(photo!, width: MediaQuery.of(context).size.width / 1.1, height: 300, fit: BoxFit.cover),
                        ),
                      )
                    : Container(height: MediaQuery.of(context).size.height / 2.5),
                const SizedBox(height: 10),
                photo != null
                    ? Row(
                        children: const [
                          SizedBox(width: 20),
                          Text("Say something about photo"),
                        ],
                      )
                    : const Text(""),
                photo == null
                    ? const Text("")
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(controller: titlecontroller),
                      ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    ToggleButtons(
                      isSelected: isSelected,
                      selectedColor: Colors.green,
                      color: Colors.red,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Public", style: TextStyle(fontSize: 17)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Private", style: TextStyle(fontSize: 17)),
                        ),
                      ],
                      onPressed: (int newIndex) {
                        setState(() {
                          if (newIndex == 0) {
                            publicornot = true;
                          } else {
                            publicornot = false;
                          }
                          for (int index = 0; index < isSelected.length; index++) {
                            if (index == newIndex) {
                              isSelected[index] = true;
                            } else {
                              isSelected[index] = false;
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    _showPicker(context);
                  },
                  tileColor: Colors.white10,
                  leading: const Icon(Icons.photo, color: Colors.black87),
                  title: const Text("Photo"),
                ),
                const SizedBox(height: 10),
                const ListTile(
                  tileColor: Colors.white10,
                  leading: Icon(Icons.textsms, color: Colors.black87),
                  title: Text("Text"),
                ),
              ],
            ),
          ),
        ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    tileColor: Colors.black54,
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  tileColor: Colors.black54,
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> uploadImage(String title) async {
    if (photo == null) return;

    if (publicornot) {
      final storageRef = firebase_storage.FirebaseStorage.instance;
      File file = File(photo!.path);
      var date = DateTime.now().microsecondsSinceEpoch.toString();
      var a = date;
      try {
        isuploaded = true;
        firebase_storage.Reference ref = storageRef.ref('/${firebaseuser.uid}/Public/$date');
        firebase_storage.UploadTask uploadtask = ref.putFile(file);
        await Future.value(uploadtask);
        var newUrl = await ref.getDownloadURL();
        myRef.child('Posts/Public/$a').set({'title': title, 'link': newUrl.toString(), 'foldername': a});
        myRef.child('Post/$a').set({'title': title, 'link': newUrl.toString(), 'foldername': a});

        // ignore: use_build_context_synchronously
        ShowDialog.backtoHomeAfterUpload(context);
        isuploaded = false;
      } on firebase_storage.FirebaseException {}
    }
    if (!publicornot) {
      final storageRef = firebase_storage.FirebaseStorage.instance;
      File file = File(photo!.path);
      var date = DateTime.now().microsecondsSinceEpoch.toString();
      var a = date;
      try {
        isuploaded = true;
        firebase_storage.Reference ref = storageRef.ref('/${firebaseuser.uid}/Private/$date');
        firebase_storage.UploadTask uploadtask = ref.putFile(file);
        await Future.value(uploadtask);
        var newUrl = await ref.getDownloadURL();
        myRef.child('Posts/Private/$a').set({'title': title, 'link': newUrl.toString(), 'foldername': a});
        myRef.child('Post/$a').set({'title': title, 'link': newUrl.toString(), 'foldername': a});

        // ignore: use_build_context_synchronously
        ShowDialog.backtoHomeAfterUpload(context);
        isuploaded = false;
      } on firebase_storage.FirebaseException {}
    }
  }
}
