import 'dart:ffi';

import 'package:flutter/material.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        title: Text("Profile Screen", style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120, 
                height: 120, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), 
                  child: Image(
                    image: AssetImage('Assets/profile.png'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Blablablabla@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 15)),
              SizedBox(height: 60),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  enabled: isEditing,
                  prefixIcon: Icon(Icons.people, color: Colors.blue),
                ),
                initialValue: "Nama yang udah di edit",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "About",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  enabled: isEditing,
                  prefixIcon: Icon(Icons.info, color: Colors.blue),
                ),
                initialValue: "Hello, im using CloudTalk",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 60),
              SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
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
                      Text(isEditing ? "SAVE" : "UPDATE", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
