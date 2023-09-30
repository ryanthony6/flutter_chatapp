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

  final updateName = TextEditingController();
  final updateStatus = TextEditingController();
  File? imageFile;

  void updateNewUser() async {
    await firestore.collection('users').doc(widget.uid).update({
      'name': updateName.text,
      'about': updateStatus.text,
    });
  }

  Future<void> uploadImage(File image) async {
    try {
      // Define a reference to the Firebase Storage location where you want to store the image.
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(widget.uid);

      // Upload the image to Firebase Storage.
      UploadTask uploadTask = storageRef.putFile(image);

      // Get the download URL of the uploaded image.
      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      // Update the Firestore document with the image URL.
      await firestore.collection('users').doc(widget.uid).update({
        'profile_picture': imageUrl,
      });

      // Set the imageFile variable to the new image.
      setState(() {
        imageFile = image;
      });
    } catch (error) {
      // Handle any errors that occur during image upload.
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
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0.5,
        title: Text("Setup your profile",
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
      ),
      body: Center(
        child: Form(
          key: _formfield,
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
                  Text('click to edit your profile picture',
                      style: TextStyle(color: Colors.grey, fontSize: 15)),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: updateName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.people, color: Colors.blue),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: updateStatus,
                    decoration: InputDecoration(
                      labelText: "About",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.info, color: Colors.blue),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 60),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formfield.currentState!.validate()) {
                          _formfield.currentState!.save();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        }
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
      ),
    );
  }
}
