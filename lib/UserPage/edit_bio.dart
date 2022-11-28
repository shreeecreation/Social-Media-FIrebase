import 'package:firebase_authentication/UserPage/user_screen.dart';
import 'package:firebase_authentication/_Codes/Authentication/Auth.dart';
import 'package:flutter/material.dart';

class EditBio extends StatefulWidget {
  const EditBio({Key? key, required this.intitalBio}) : super(key: key);
  final String intitalBio;
  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  final textfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Bio"),
        actions: [
          TextButton(
              onPressed: textfield.text.isEmpty || textfield.text == widget.intitalBio
                  ? null
                  : () async {
                      await Auth.addBio(textfield.text);
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil<void>(
                          context, MaterialPageRoute<void>(builder: (BuildContext context) => const UserPage()), (Route<dynamic> route) => false);
                    },
              child: const Text("Save"))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(Auth.photolink), radius: 28),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Auth.username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 3),
                    const Text("Public Id", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (e) {
                setState(() {});
              },
              controller: textfield,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  helperMaxLines: 5,
                  helperText:
                      "You can add a short bio to tell people more about yourself. This can be anything such as a favourite quote or what makes you happy."),
              maxLines: 5,
              // initialValue: widget.intitalBio == null  ? "": ,
              maxLength: 100,
            ),
          )
        ],
      ),
    );
  }
}
