import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formfield = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF376AED),
        centerTitle: true,
        elevation: 0.5,
        title: Text("Edit Profile Screen",
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
      ),
      body: Form(
        key: _formfield,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                        }
                      },
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                              File(_image!),
                              fit: BoxFit.cover,
                            ))
                          : ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: widget.user.image,
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(child: Icon(Icons.person)),
                              ),
                            )),
                ),
                SizedBox(height: 20),
                Text(widget.user.email,
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
                SizedBox(height: 60),
                TextFormField(
                  onSaved: (val) => APIs.me.name = val ?? '',
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
                  initialValue: widget.user.name,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onSaved: (val) => APIs.me.about = val ?? '',
                  decoration: InputDecoration(
                    labelText: "About",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    prefixIcon: Icon(Icons.info, color: Colors.blue),
                  ),
                  initialValue: widget.user.about,
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
                        APIs.updateUserInfo().then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Profile updated successfully',
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ));
                        });
                      }
                      ;
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
