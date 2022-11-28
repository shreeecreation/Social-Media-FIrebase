import 'package:firebase_authentication/UserPage/All%20Post/bloc/post_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/manageCodePost.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/private_bloc.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TabBar(
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              enableFeedback: true,
              splashBorderRadius: const BorderRadius.all(Radius.circular(50)),
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black45,
              controller: tabcontroller,
              tabs: const [Text("Private"), Tab(text: "Public")]),
          SizedBox(
              // width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 2.5,
              child: TabBarView(controller: tabcontroller, children: [
                BlocBuilder<PrivateBloc, PrivateState>(builder: (context, state) {
                  if (state is PostLoadinState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50, child: Text("Add Some of the Photos")),
                        SizedBox(height: 50, width: 50, child: ManagePrivatePost.privatepost()),
                      ],
                    );
                  }
                  if (state is PostfetchState) {
                    return Column(
                      children: [
                        ManagePrivatePost.privatepostwidget(),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
                BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                  if (state is Postloading) {
                    return Column(
                      children: [
                        SizedBox(height: 50, width: 50, child: ManagePublicPost.publicpost()),
                        const SizedBox(height: 50, child: Text("Add Some of the Photos")),
                      ],
                    );
                  }
                  if (state is PostFetch) {
                    return ManagePublicPost.publicpostwidget();
                  }
                  return const CircularProgressIndicator();
                }),
              ]))
        ],
      ),
    );
  }
}
