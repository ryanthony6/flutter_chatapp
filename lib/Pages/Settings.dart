import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/editProfile.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/auth/registerPage.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final ChatUser user;

  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF376AED),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 10),
            editProfileOption(context, 'Edit Profile'),
            SizedBox(
              height: 10,
            ),
            changePasswordOption(context, 'Change Password'),
            SizedBox(
              height: 10,
            ),
            deleteAccountOption(context, 'Delete Account')
          ],
        ),
      ),
    );
  }

  GestureDetector editProfileOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ProfileScreen(user: APIs.me)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }

  GestureDetector changePasswordOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your password has been reset, check your email")
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        auth_service().resetPassword(widget.user.email);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text('Close'))
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }

  GestureDetector deleteAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Are you sure want delete this account?")],
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.currentUser?.delete();
                      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).delete();
                      APIs.deleteDocumentByField;
                      
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => splashScreen()),
                          (route) => false);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
