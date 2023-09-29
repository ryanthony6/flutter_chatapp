import 'package:chatapp/models/chatUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  // current user
  static get user => auth.currentUser!;

  // delete user from database
  Future<void> deleteDocumentByField() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  // check if user exists
  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(user.uid)
            .get())
        .exists;
  }

  // creating new user to firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey im using wewewewewe",
        image: user.photoURL.toString(),
        createdAt: time,
        // isOnline: false
        lastActive: time,
        pushToken: '');

    return (await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson()));
  }
}
