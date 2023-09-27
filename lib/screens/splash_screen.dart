import 'dart:async';

import 'package:chatapp/screens/auth/email_verif.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/onboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

     Future.delayed(Duration(seconds: 2), () {
       if (FirebaseAuth.instance.currentUser == null) {
        // user not logged ==> Login Screen
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => onboardScreen()), (route) => false);
        // user email not verified but suddenly force close 
      } else {
        // user already logged in ==> Home Screen
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      }
     }
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'img/splash.png',
            )
          ],
        ),
      ),
    );
  }
}
