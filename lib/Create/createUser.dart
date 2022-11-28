// ignore_for_file: non_constant_identifier_names

import 'package:firebase_authentication/Login/login_screen.dart';
import 'package:firebase_authentication/Utils/Dialogbox.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';

import '../Utils/clippath.dart';

// ignore: must_be_immutable
class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  bool obscure = false; //Password seen or unseen
  bool obscure1 = false; //Password seen or unseen
  final email = TextEditingController();

  final password = TextEditingController();

  final c_password = TextEditingController();
  final username = TextEditingController();
  final profession = TextEditingController();

  bool email_validator = false;

  bool pass_validator = false;
  bool username_validator = false;
  bool profession_validator = false;

  late bool createId;

  final formkeys = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    c_password.dispose();
    username.dispose();
    profession.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 450),
                    color: Colors.blue.withOpacity(.8),
                    height: 220,
                    alignment: Alignment.center,
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    color: Colors.blue.withOpacity(.3),
                    height: 180,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            Form(
              key: formkeys,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    nameText(),
                    const SizedBox(height: 20),
                    professionText(),
                    const SizedBox(height: 20),
                    emailText(email),
                    const SizedBox(height: 20),
                    passwordText(password),
                    const SizedBox(height: 20),
                    c_passwordText(password, context),
                    const SizedBox(height: 30),
                    signIn(context, email, password, formkeys),
                    const SizedBox(height: 18),
                    const SizedBox(height: 15),
                    const Text("---------------------- OR ------------------------"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
                        },
                        child: const Text("Already have an account ? Login", style: TextStyle(fontWeight: FontWeight.w300)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField nameText() {
    return TextFormField(
      controller: username,
      decoration: const InputDecoration(
        labelText: "Username",
      ),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      // autofocus: false,
      // keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          username_validator = false;
          return 'Username is empty !';
        }
        username_validator = true;

        return null;
      },
    );
  }

  TextFormField professionText() {
    return TextFormField(
      controller: profession,
      decoration: const InputDecoration(
        labelText: "Profession",
      ),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          profession_validator = false;
          return 'Profession is empty !';
        }
        profession_validator = true;

        return null;
      },
    );
  }

  TextFormField emailText(TextEditingController email) {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        labelText: "Email",
      ),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      // autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          email_validator = false;
          return 'Enter a valid email!';
        }
        email_validator = true;

        return null;
      },
    );
  }

  TextFormField passwordText(TextEditingController password) {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscure = !obscure;
              });
            },
            child: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          )),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      obscureText: obscure ? false : true,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a valid password!';
        }
        if (value.length < 6) {
          pass_validator = false;

          return 'Invalid Password';
        }

        return null;
      },
    );
  }

  TextFormField c_passwordText(TextEditingController password, var context) {
    return TextFormField(
      controller: c_password,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscure1 = !obscure1;
            });
          },
          child: Icon(obscure1 ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      obscureText: obscure1 ? false : true,
      autofocus: false,
      validator: (value) {
        if (value == password.text && value!.length >= 6) {
          pass_validator = true;
        } else {
          if (value!.length < 5) {
            return 'Invalid password!';
          }
          if (value.length >= 5) {
            ShowDialog.showMyDialog(context, "Password doesn't match");
          }
        }

        return null;
      },
    );
  }

  SizedBox signIn(context, TextEditingController email, TextEditingController password, GlobalKey<FormState> formkey) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0.5),
          onPressed: () {
            formkey.currentState!.validate();
            if (email_validator && pass_validator && username_validator) {
              createId = true;
            } else {
              createId = false;
            }
            Auth.createUser(email.text, password.text, context, createId, username.text, profession.text);
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("SIGN IN", style: TextStyle(fontSize: 15)),
          )),
    );
  }
}
