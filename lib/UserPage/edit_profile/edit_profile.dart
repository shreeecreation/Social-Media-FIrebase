import 'package:firebase_authentication/UserPage/All%20Post/bloc/post_bloc.dart';
import 'package:firebase_authentication/UserPage/user_screen.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.username, required this.bio, required this.profession}) : super(key: key);
  final String username;
  final String bio;
  final String profession;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final usernameValidator = TextEditingController();

// ignore: unnecessary_null_comparison
final bioValidator = TextEditingController();
final professionValidator = TextEditingController();

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    usernameValidator.text = widget.username;
    bioValidator.text = widget.bio;
    professionValidator.text = widget.profession;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), elevation: 0, backgroundColor: Colors.transparent, actions: [
        TextButton(
            onPressed: usernameValidator.text != widget.username || bioValidator.text != widget.bio || professionValidator.text != widget.profession
                ? () {
                    Auth.updateProfile(bioValidator.text, usernameValidator.text, professionValidator.text);
                    context.read<PostBloc>().add(Postfetchevent());

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const UserPage()), (route) => false);
                  }
                : null,
            child: const Text("Save"))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Divider(
            color: Colors.black,
          ),
          TextFormField(
              onChanged: (e) {
                setState(() {});
              },
              controller: usernameValidator,
              decoration: const InputDecoration(labelText: "Username"),
              textInputAction: TextInputAction.next,
              cursorColor: Colors.black,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              maxLength: 30),
          const SizedBox(height: 10),
          TextFormField(
              onChanged: (e) {
                setState(() {});
              },
              controller: bioValidator,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Bio"),
              maxLines: 5,
              maxLength: 100),
          const SizedBox(height: 10),
          TextFormField(
            controller: professionValidator,
            decoration: const InputDecoration(labelText: "Profession"),
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            maxLength: 30,
            onChanged: (e) {
              setState(() {});
            },
          ),
          const SizedBox(height: 10),
          const Text("Edit your profile. Show your updates to your friends", style: TextStyle(color: Colors.white54))
        ]),
      ),
    );
  }
}

class Profess extends StatefulWidget {
  const Profess({
    Key? key,
    required this.professionValidator,
  }) : super(key: key);

  final TextEditingController professionValidator;

  @override
  State<Profess> createState() => _ProfessState();
}

class _ProfessState extends State<Profess> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.professionValidator,
      decoration: const InputDecoration(labelText: "Profession"),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
      onChanged: (e) {
        setState(() {});
      },
    );
  }
}
