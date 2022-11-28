import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/UserPage/All%20Post/foldername.dart';
import 'package:firebase_authentication/Utils/UserScreen/userdefaultphotolink.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostViewImage extends StatefulWidget {
  const PostViewImage({Key? key, required this.index, required this.publicorprivate}) : super(key: key);
  final int index;
  final bool publicorprivate;
  @override
  State<PostViewImage> createState() => _PostViewImageState();
}

class _PostViewImageState extends State<PostViewImage> {
  String photolink = PhotoLink.blackimage;
  String caption = "";
  @override
  void initState() {
    String photofolder = widget.publicorprivate ? Foldername.foldernamepubilc[widget.index] : Foldername.foldername[widget.index];
    final databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/Post/$photofolder");
    Future getlink() async {
      await databaseRef.get().then((e) {
        setState(() {
          photolink = (e.value! as dynamic)['link'];
          caption = (e.value! as dynamic)['title'];
        });
      });
    }

    getlink();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Colors.black, height: MediaQuery.of(context).size.height),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(PhotoLink.link), radius: 28),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(PhotoLink.username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 3),
                      const Text("", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Image.network(photolink, width: MediaQuery.of(context).size.width / 1.1, height: 300, fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Text(caption),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
