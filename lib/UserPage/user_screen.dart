import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/OtherUserProfile/otheruser.dart';
import 'package:firebase_authentication/UserPage/All%20Post/bloc/post_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/managecodepost.dart';
import 'package:firebase_authentication/UserPage/All%20Post/post.dart';
import 'package:firebase_authentication/UserPage/Viewphoto/caption.dart';
import 'package:firebase_authentication/UserPage/edit_bio.dart';
import 'package:firebase_authentication/UserPage/edit_profile/edit_profile.dart';
import 'package:firebase_authentication/UserPage/getpostlength/getpostpublic/bloc/get_post_public_bloc.dart';
import 'package:firebase_authentication/Utils/Dialogbox.dart';
import 'package:firebase_authentication/Utils/NavigationBar/navigationbar.dart';
import 'package:firebase_authentication/Utils/UserScreen/userdefaultphotolink.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'All Post/bloc/private_bloc.dart';
import 'getpostlength/bloc/getpost_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    context.read<PrivateBloc>().add(PostLoadingPrivate());
    context.read<PostBloc>().add(Postfetchevent());

    return Scaffold(
        bottomNavigationBar: const Navigation(),
        appBar: AppBar(
            backgroundColor: Colors.black26,
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    ShowDialog.logOut(context);
                  })
            ],
            title: Text("${user!.email}", style: const TextStyle(fontSize: 15))),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                  child: CountPost.privatepost(),
                ),
                SizedBox(
                  height: 10,
                  child: CountPost.publicpost(),
                ),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        FutureBuilder(
                            future: Auth.fetchUser(),
                            builder: (context, e) {
                              PhotoLink.link = Auth.photolink;
                              PhotoLink.username = Auth.username;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8, width: 4),
                                  GestureDetector(
                                      onTap: () {
                                        ShowDialog.uploadPhotoDialog(context, Auth.photolink, Caption.caption);
                                      },
                                      child: CircleAvatar(backgroundImage: NetworkImage(Auth.photolink), radius: 50)),
                                  const SizedBox(width: 30),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        "Private Posts",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const SizedBox(height: 20),
                                      BlocBuilder<GetpostBloc, GetpostState>(
                                        builder: (context, state) {
                                          if (state is GetPostLoadingState) {
                                            return const Text(
                                              "- ",
                                              style: TextStyle(fontSize: 17),
                                            );
                                          }
                                          if (state is GetPostFetchState) {
                                            return Text(
                                              "${(CountPost.a).toString()} ",
                                              style: const TextStyle(fontSize: 17),
                                            );
                                          }
                                          return const Text("");
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        "Public Posts",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const SizedBox(height: 20),
                                      BlocBuilder<GetPostPublicBloc, GetPostPublicState>(
                                        builder: (context, state) {
                                          if (state is GetPostPublicLoadingState) {
                                            return const Text(
                                              "- ",
                                              style: TextStyle(fontSize: 17),
                                            );
                                          }
                                          if (state is GetPostPublicFetchState) {
                                            return Text(
                                              "${(CountPost.b).toString()} ",
                                              style: const TextStyle(fontSize: 17),
                                            );
                                          }
                                          return const Text("");
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                        //Baisc Details
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FutureBuilder(
                              future: Auth.fetchUser(),
                              builder: (context, e) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      const SizedBox(height: 8),
                                      Text(Auth.username, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                                      const SizedBox(height: 5),
                                      Text(Auth.profession, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                                      const SizedBox(height: 2),
                                      Auth.bio == "" || Auth.bio == null
                                          ? addBioButton(context)
                                          : Text(Auth.bio, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ]),
                    )),
                editProfileButton(context),
                seeProfile(context),
                const UserPost(),
              ],
            ),
          ),
        ));
  }

  static Widget addBioButton(BuildContext context) {
    return SizedBox(
        height: 30,
        width: MediaQuery.of(context).size.width / 1.1,
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditBio(intitalBio: Auth.bio.isEmpty ? "" : Auth.bio)));
            },
            child: const Text("Add Bio")));
  }

  Widget editProfileButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditProfile(username: Auth.username, bio: Auth.bio, profession: Auth.profession)));
                },
                style: ElevatedButton.styleFrom(primary: Colors.white12, elevation: 0.5),
                child: const Text("Edit Profile"))),
        IconButton(icon: const Icon(Icons.mobile_screen_share_outlined), onPressed: () {})
      ],
    );
  }

  Widget seeProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const OtherUser()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.white12, elevation: 0.5),
                child: const Text("See other Profiles"))),
      ],
    );
  }
}
// Two Bloc
// icon 
// name  
// apk
// pustak thana tiktok 
// tiktok empirecosmetics
