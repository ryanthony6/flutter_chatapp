import 'dart:async';

import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/utils/verif.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isEmailVerified = false;
  Timer? timer;

  void initState(){
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      auth_service().emailVerif();

      timer = Timer.periodic(Duration(seconds: 3),
      (_) => checkEmailVerified());
    }
  }

   Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) {
      timer?.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  
  void _showAlertDialog(String message) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
          );
        },
      );
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage('img/Verif.png')
              ),
            ),
            Text("Verify your email address", style: tTextStyle.copyWith(fontWeight: bold, fontSize: 20), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text("We have just send email verification link on \n your email. Please check your email and click on \n that link to verify your Email address.", style: codeSent.copyWith(fontSize: 14), textAlign: TextAlign.center),
            SizedBox(height: 15),
            Text("If not auto redirected after verification, click \n on the continue button.", style: tTextStyle.copyWith(fontSize: 14), textAlign: TextAlign.center),
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: InkWell(
                onTap: () {
                  checkEmailVerified();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Continue", style: tTextStyle.copyWith(fontSize: 15))
                  )
                )
              )
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                auth_service().emailVerif();
                _showAlertDialog('Please check your email');
              },
              child: Text("Resend E-Mail Link", style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Back to login", style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}