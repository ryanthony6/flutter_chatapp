import 'package:chatapp/screens/onboard_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() {
  _initialFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      title: 'Nama Aplikasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.normal
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF376AED)
        )
      ),
      home: const onboardScreen()
    );
  }
}

_initialFirebase() async{
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
}