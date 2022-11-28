import 'package:firebase_authentication/OtherUserProfile/OtherBloc/bloc/otheruser_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherUserPhoto {
  static String docid = "";

  static var photolink = [];
  static var caption = [];

  static Widget publicpost() {
    var ref = FirebaseDatabase.instance.ref(("$docid/Posts/Public"));
    return FirebaseAnimatedList(
        query: ref,
        itemBuilder: ((context, snapshot, animation, index) {
          if (!photolink.contains((snapshot.value! as dynamic)['link'])) {
            photolink.add((snapshot.value! as dynamic)['link']);
          }
          if (!caption.contains((snapshot.value! as dynamic)['title'])) {
            caption.add((snapshot.value! as dynamic)['link']);
          }
          if (!Foldername.otherfolder.contains((snapshot.value! as dynamic)['foldername'])) {
            Foldername.otherfolder.add((snapshot.value! as dynamic)['foldername']);
          }
          context.read<OtheruserBloc>().add(OhterUserFetchEvent());

          return const SizedBox();
        }));
  }

  static Widget publicpostwidget(BuildContext context) {
    return photolink.isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
                itemCount: photolink.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) => PostViewImage(
                      //               index: index,
                      //               publicorprivate: true,
                      //             )));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Image.network(photolink[index], width: MediaQuery.of(context).size.width / 1.1, height: 300, fit: BoxFit.cover),
                    ),
                  );
                }),
          )
        : const Center(child: Text("No Photo Available in this Users"));
  }
}
