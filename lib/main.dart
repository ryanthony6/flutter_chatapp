
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/ChatDetails.dart';
import 'package:chatapp/Pages/editProfile.dart';
import 'package:chatapp/Pages/Chats.dart';
import 'package:chatapp/Pages/Settings.dart';
import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/auth/registerPage.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/newUserProfile.dart';
import 'package:chatapp/screens/onboard_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen()
    );
  }
  
}


