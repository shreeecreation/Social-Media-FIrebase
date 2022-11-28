// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/UserPage/All%20Post/bloc/post_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_authentication/UserPage/All%20Post/postview_image.dart';
import 'package:firebase_authentication/UserPage/getpostlength/bloc/getpost_bloc.dart';
import 'package:firebase_authentication/UserPage/getpostlength/getpostpublic/bloc/get_post_public_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/private_bloc.dart';

class ManagePublicPost {
  static var photolink = [];
  static var caption = [];

  static Widget publicpost() {
    var ref = FirebaseDatabase.instance.ref(("${FirebaseAuth.instance.currentUser!.uid}/Posts/Public"));
    return FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (!photolink.contains((snapshot.value! as dynamic)['link'])) {
            photolink.add((snapshot.value! as dynamic)['link']);
          }
          if (!caption.contains((snapshot.value! as dynamic)['title'])) {
            caption.add((snapshot.value! as dynamic)['link']);
          }
          if (!Foldername.foldernamepubilc.contains((snapshot.value! as dynamic)['foldername'])) {
            Foldername.foldernamepubilc.add((snapshot.value! as dynamic)['foldername']);
          }
          context.read<PostBloc>().add(PostFetched());
          return const SizedBox();
        }));
  }

  static Widget publicpostwidget() {
    return SizedBox(
      height: 300,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
          itemCount: photolink.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PostViewImage(
                              index: index,
                              publicorprivate: true,
                            )));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Image.network(photolink[index], width: MediaQuery.of(context).size.width / 1.1, height: 300, fit: BoxFit.cover),
              ),
            );
          }),
    );
  }
}

class ManagePrivatePost {
  final user = FirebaseAuth.instance.currentUser;

  static var photolink = [];
  static var caption = [];

  static Widget privatepost() {
    var ref = FirebaseDatabase.instance.ref(("${FirebaseAuth.instance.currentUser!.uid}/Posts/Private"));

    return FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (!photolink.contains((snapshot.value! as dynamic)['link'])) {
            photolink.add((snapshot.value! as dynamic)['link']);
          }
          if (!caption.contains((snapshot.value! as dynamic)['title'])) {
            caption.add((snapshot.value! as dynamic)['link']);
          }
          if (!Foldername.foldername.contains((snapshot.value! as dynamic)['foldername'])) {
            Foldername.foldername.add((snapshot.value! as dynamic)['foldername']);
          }
          context.read<PrivateBloc>().add(PostFetchedEvent());
          return const SizedBox();
        }));
  }

  static Widget privatepostwidget() {
    return SizedBox(
      height: 300,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
          itemCount: photolink.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PostViewImage(
                              index: index,
                              publicorprivate: false,
                            )));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Image.network(photolink[index], width: MediaQuery.of(context).size.width / 1.1, height: 300, fit: BoxFit.cover),
              ),
            );
          }),
    );
  }
}

class CountPost {
  static int a = 0;
  static int b = 0;

  static Widget privatepost() {
    var ref = FirebaseDatabase.instance.ref(("${FirebaseAuth.instance.currentUser!.uid}/Posts/Private"));

    return FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (!Foldername.totalpostprivate.contains((snapshot.value! as dynamic)['foldername'])) {
            Foldername.totalpostprivate.add((snapshot.value! as dynamic)['foldername']);
            Foldername.length = Foldername.totalpostprivate.length;
          }
          a = Foldername.totalpostprivate.length;

          context.read<GetpostBloc>().add(GetPostFetchEvent());
          return const SizedBox();
        }));
  }

  static Widget publicpost() {
    var ref = FirebaseDatabase.instance.ref(("${FirebaseAuth.instance.currentUser!.uid}/Posts/Public"));

    return FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (!Foldername.totalpostpublic.contains((snapshot.value! as dynamic)['foldername'])) {
            Foldername.totalpostpublic.add((snapshot.value! as dynamic)['foldername']);
          }
          b = Foldername.totalpostpublic.length;
          print(b);
          context.read<GetPostPublicBloc>().add(GetPostPublicFetchEvent());

          return const SizedBox();
        }));
  }
}
