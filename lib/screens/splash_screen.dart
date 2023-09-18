import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> 
with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => onboardScreen(),
        )
      );
     }
    );
  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
      
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFf5fff9)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud,size: 80,color: Color(0xFF376AED)),
            SizedBox(height: 4),
            Text('cloudTalk',
            style: TextStyle(
              color: Color(0xFF376AED),
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      
       
      ),
    );
  }
}


