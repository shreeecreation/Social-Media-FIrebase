// ignore_for_file: file_names
import 'package:firebase_authentication/OtherUserProfile/OtherBloc/bloc/otheruser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_otheruser_photo.dart';

class OtherUserviewer extends StatelessWidget {
  const OtherUserviewer({Key? key, required this.uid, required this.username, required this.email, required this.bio, required this.photo})
      : super(key: key);
  final String uid;
  final String username;
  final String email;
  final String bio;
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black26, title: Text(username, style: const TextStyle(fontSize: 15))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(photo), radius: 80),
                ],
              ),
              const SizedBox(height: 20),
              Text(username, style: const TextStyle(fontSize: 18)),
              Text(bio, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              const Text("Public Posts", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              BlocBuilder<OtheruserBloc, OtheruserState>(builder: (context, state) {
                if (state is OtheruserLoadingState) {
                  return Column(
                    children: [
                      SizedBox(height: 50, width: 50, child: OtherUserPhoto.publicpost()),
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: OtherUserPhoto.photolink.isNotEmpty
                              ? const CircularProgressIndicator()
                              : const Center(child: Text("No Photo Available in this User"))),
                    ],
                  );
                }
                if (state is OtheruserFetchState) {
                  return OtherUserPhoto.publicpostwidget(context);
                }
                return const Text("No Photo Available in this User");
              }),
            ],
          ),
        ));
  }
}
