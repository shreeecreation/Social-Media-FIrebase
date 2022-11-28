import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Create/createUser.dart';
import 'package:firebase_authentication/UserPage/user_screen.dart';
import 'package:firebase_authentication/Utils/clippath.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              email.text = "";
              password.text = "";
              return const UserPage();
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error!"));
            } else {
              return logInWid(email, password, context);
            }
          }),
    ));
  }

  Widget logInWid(TextEditingController email, TextEditingController password, var context) {
    final formkey = GlobalKey<FormState>();
    return SingleChildScrollView(
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
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  emailText(email),
                  const SizedBox(height: 20),
                  PasswordWidget(password: password),
                  const SizedBox(height: 30),
                  loginBtn(context, email, password, formkey),
                  const SizedBox(height: 18),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(height: 15),
                  const Text("---------------------- OR ------------------------"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const CreateUser()));
                      },
                      child: const Text("Create New Firebase Account", style: TextStyle(fontWeight: FontWeight.w300))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField emailText(TextEditingController email) {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(labelText: "Email"),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'Enter a valid email!';
        }
        return null;
      },
    );
  }

  SizedBox loginBtn(context, TextEditingController email, TextEditingController password, GlobalKey<FormState> formkey) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0.5),
          onPressed: () {
            Auth.signIn(email.text, password.text, context, formkey.currentState!.validate());
            bool valid = formkey.currentState!.validate();
            if (valid) {
              password.text = password.text;
              email.text = email.text;
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("LOG IN", style: TextStyle(fontSize: 15)),
          )),
    );
  }
}

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    Key? key,
    required this.password,
  }) : super(key: key);

  final TextEditingController password;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.password,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: Icon(obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      obscureText: obscure ? false : true,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a valid password!';
        }
        if (value.length < 6) {
          return 'Invalid Password';
        }
        return null;
      },
    );
  }
}
