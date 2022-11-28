import 'package:cloud_firestore/cloud_firestore.dart';

class OtherUsers {
  static final CollectionReference profileList = FirebaseFirestore.instance.collection('basicdetails');

  static Future getUserList() async {
    List itemList = [];
    try {
      await profileList.get().then((value) {
        for (var element in value.docChanges) {
          itemList.add(element.doc);
        }
      });

      return itemList;
    } catch (e) {
      return null;
    }
  }
}
