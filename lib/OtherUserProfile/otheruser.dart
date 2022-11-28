import 'package:firebase_authentication/OtherUserProfile/get_otheruser_photo.dart';
import 'package:firebase_authentication/OtherUserProfile/otherUserViewer.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_authentication/Utils/UserScreen/userdefaultphotolink.dart';
import 'package:firebase_authentication/_Codes/OtherUser/other_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OtherBloc/bloc/otheruser_bloc.dart';

class OtherUser extends StatefulWidget {
  const OtherUser({Key? key}) : super(key: key);

  @override
  State<OtherUser> createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  List userprofiles = [];
  @override
  void initState() {
    fetchDatabaseList();

    super.initState();
  }

  fetchDatabaseList() async {
    dynamic result = await OtherUsers.getUserList();
    if (result == null) {
    } else {
      setState(() {
        userprofiles = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our family"),
      ),
      body: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: userprofiles.length,
          itemBuilder: ((context, index) {
            return Card(
              child: SizedBox(
                height: 80,
                child: Center(
                  child: ListTile(
                      onTap: () {
                        OtherUserPhoto.docid = userprofiles[index]['docid'];
                        Foldername.otherfolder.clear();
                        OtherUserPhoto.photolink.clear();
                        context.read<OtheruserBloc>().add(OhterUserLoadingEvent());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => OtherUserviewer(
                                      bio: userprofiles[index]['bio'],
                                      email: userprofiles[index]['email'],
                                      photo: userprofiles[index]['photo'],
                                      uid: userprofiles[index]['docid'],
                                      username: userprofiles[index]['username'],
                                    )));
                      },
                      title: Text(userprofiles[index]['username']),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(userprofiles[index]['photo'] == "" ? PhotoLink.link : userprofiles[index]['photo']),
                          radius: 25)),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
