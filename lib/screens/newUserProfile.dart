import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class newUserProf extends StatefulWidget {
  final String uid;

  newUserProf(this.uid);
  @override
  _newUserProfState createState() => _newUserProfState();
}

class _newUserProfState extends State<newUserProf> {
  final _formfield = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  File? imageFile;

  Future<void> uploadImage(File image) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(widget.uid);

      UploadTask uploadTask = storageRef.putFile(image);

      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      await firestore.collection('users').doc(widget.uid).update({
        'image': imageUrl,
      });

      setState(() {
        imageFile = image;
      });
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  void imageSelect(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF376AED),
        centerTitle: true,
        elevation: 0.5,
        title: Text("Setup your profile",
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(imageFile!, fit: BoxFit.cover),
                          )
                        : Icon(Icons.person, size: 120, color: Colors.grey),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Image Profile Picture'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    await uploadImage(File(pickedFile.path));
                                  }
                                },
                                title: Text('Gallery'),
                                leading: Icon(Icons.photo_album),
                              ),
                              ListTile(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (pickedFile != null) {
                                    await uploadImage(File(pickedFile.path));
                                  }
                                },
                                title: Text('Camera'),
                                leading: Icon(Icons.camera),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text('Click the icon to change your profile picture',
                      style: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: StadiumBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 7),
                        Text('Update')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
