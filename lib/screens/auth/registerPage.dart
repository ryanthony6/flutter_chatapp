import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/editProfile.dart';
import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/email_verif.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/newUserProfile.dart';
import 'package:chatapp/utils/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _formfield = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberMe = false;
  User? user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _showAlertDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        );
      },
    );
  }

  void _handleSignUp() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (_formfield.currentState!.validate()) {
      _formfield.currentState!.save();

      User? user = await auth_service()
          .signUpWithEmailAndPassword(email.text, password.text);

      if (user != null) {
        final time = DateTime.now().millisecondsSinceEpoch.toString();
        await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
          "name": name.text,
          "email": email.text,
          "id": _auth.currentUser?.uid,
          "about": "Hello! Nice to meet you",
          "image": 'null',
          "createdAt": time,
          "lastActive": time,
          "pushToken": '',
          // "name" : name,
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Verification()));
      } else {
        _showAlertDialog('Email for that user already exists');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/Background.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formfield,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome!",
                            style: tTextStyle.copyWith(
                                fontSize: 30, fontWeight: bold)),
                        SizedBox(height: 11),
                        Text(
                          "Welcome to cloudTalk, Please sign up to continue using our app.",
                          style: tTextStyle.copyWith(fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Name",
                                style: tTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold)),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Name';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                filled: true,
                                fillColor: Color(0xFFe0e0e0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text("E-mail",
                                style: tTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold)),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your E-mail';
                                } else if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Please enter a valid E-mail';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter your E-mail",
                                filled: true,
                                fillColor: Color(0xFFe0e0e0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Password",
                                    style: tTextStyle.copyWith(
                                        fontSize: 15, fontWeight: bold)),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: password,
                                  validator: (value) {
                                    if (value!.length < 7) {
                                      return 'Please enter a valid password (min length 7)';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      filled: true,
                                      fillColor: Color(0xFFe0e0e0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        child: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      hintStyle: tTextStyle.copyWith(
                                          fontSize: 15,
                                          color: textColor.withOpacity(0.6)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 17)),
                                  obscureText: !isPasswordVisible,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryButtonColor),
                              onPressed: () {
                                _handleSignUp();
                              },
                              child: Text("Sign Up",
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 15))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: tTextStyle.copyWith(fontSize: 16)),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginPage()));
                                },
                                child: Text("Sign in",
                                    style: tTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: bold,
                                        color: Colors.blue)))
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}
