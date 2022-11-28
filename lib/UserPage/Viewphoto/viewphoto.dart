import 'package:firebase_authentication/Utils/UserScreen/userdefaultphotolink.dart';
import 'package:flutter/material.dart';

class ViewPhotos extends StatelessWidget {
  const ViewPhotos({Key? key, required this.photolink, required this.caption}) : super(key: key);
  final String photolink;
  final String caption;
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
                  CircleAvatar(backgroundImage: NetworkImage(photolink), radius: 28),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(PhotoLink.username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 3),
                      Text(caption, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
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
