import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static late ChatUser me;

  // current user
  static get user => auth.currentUser!;


  // delete user from database
  static Future<void> deleteDocumentByField() async {
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
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // creating new user to firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hello! Nice to meet you",
        image: user.photoURL.toString(),
        createdAt: time,
        lastActive: time,
        pushToken: '');

    return (await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson()));
  }

  // get all user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // update user name and status
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // update profile picture
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('Extensio: $ext');
    final ref = storage.ref().child('profilepicture/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('data transferred: ${p0.bytesTransferred / 1000} kb');
    });
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  // chatscreen APIs

  // conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .snapshots();
  }

  // sending messages
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    // sending time
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // message to send
    final Message message = Message(
        toId: chatUser.id, msg: msg, type: type, fromId: user.uid, sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');

    await ref.doc(time).set(message.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
