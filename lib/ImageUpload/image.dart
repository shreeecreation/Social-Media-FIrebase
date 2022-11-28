import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_authentication/UserPage/All%20Post/manageCodePost.dart';
import 'package:firebase_authentication/Utils/Dialogbox.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUploads extends StatefulWidget {
  const ImageUploads({Key? key}) : super(key: key);

  @override
  ImageUploadsState createState() => ImageUploadsState();
}

class ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  var firebaseuser = FirebaseAuth.instance.currentUser!;
  DatabaseReference myRef = FirebaseDatabase.instance.ref(FirebaseAuth.instance.currentUser!.uid);
  double progress = 0;
  final biocontroller = TextEditingController();
  File? _photo;
  bool isuploaded = false;
  Future imgFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {}
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {}
    });
  }

  Future<void> uploadImage() async {
    if (_photo == null) return;
    Navigator.pop(context);
    Foldername.foldername.clear();
    Foldername.foldernamepubilc.clear();
    ManagePrivatePost.photolink.clear();
    ManagePublicPost.photolink.clear();
    final storageRef = firebase_storage.FirebaseStorage.instance;
    File file = File(_photo!.path);
    try {
      isuploaded = true;
      firebase_storage.Reference ref = storageRef.ref('/${firebaseuser.uid}/${DateTime.now().millisecondsSinceEpoch.toString()}');
      firebase_storage.UploadTask uploadtask = ref.putFile(file);
      uploadtask.snapshotEvents.listen((event) {
        setState(() {
          progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
        });
      });
      await Future.value(uploadtask);
      var newUrl = await ref.getDownloadURL();
      myRef.child('profile').set({'id': firebaseuser.uid, 'title': biocontroller.text, 'link': newUrl.toString()});
      Auth.addPhoto(newUrl.toString(), biocontroller.text);
      // ignore: use_build_context_synchronously
      ShowDialog.backtoHomeAfterUpload(context);
      setState(() {
        isuploaded = false;
      });
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ShowDialog.onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: _photo != null
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(10)),
                              child: Image.file(
                                _photo!,
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Say something about photo"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(controller: biocontroller),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Icon(Icons.camera_alt, color: Colors.black), Text("Upload an Image")],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: isuploaded == false
                      ? () {
                          _photo == null ? _showPicker(context) : ShowDialog.askingUploadPhoto(context, _photo, uploadImage);
                        }
                      : null,
                  child: Text(_photo == null ? "Choose from Storage" : "Upload")),
              const SizedBox(height: 20),
              isuploaded == true
                  ? Column(
                      children: const [Text('Uploading'), SizedBox(height: 15), CircularProgressIndicator()],
                    )
                  : const Text(""),
            ],
          ),
        ),
      ),
    );
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
                    title: const Text('Gallery'),
                    tileColor: Colors.black54,
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  tileColor: Colors.black54,
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
}
