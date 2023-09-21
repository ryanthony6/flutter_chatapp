import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class onboardScreen extends StatelessWidget {
  const onboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
     const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      titlePadding: EdgeInsets.only(top: 20),
      bodyTextStyle: TextStyle(fontSize: 19,color: Colors.black54),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 80),
    );

      return IntroductionScreen(
        globalBackgroundColor: Color(0xFFFFFFFF),
        allowImplicitScrolling: true,
        pages: [
          PageViewModel(
            title: "Simple and easy to use",
            body:
              "As simple as it should be!",
            image: Image.asset('img/slide1.png',width: 400,),
            decoration: pageDecoration,
          ),

          PageViewModel(
            title: "Safe and Secure",
            body:
              "Ensure your privacy and confidentiality",
            image: Image.asset('img/i.png',width: 400),
            decoration: pageDecoration,
          ),

          PageViewModel(
            title: "Connect yourself with others",
            body:
              "Make new friends around the world!",
            image: Image.asset('img/slide3.png',width: 400),
            decoration: pageDecoration,
          ),

          PageViewModel(
            title: "Start your journey with us!",
            body:
              "Explore more and learn more about us!",
            image: Image.asset('img/slide4.png',width: 400),
            decoration: pageDecoration,
          ),

        ],
        onDone: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (_) => LoginPage()
          ));

        },
        showSkipButton: true,
        showNextButton: true,
        showBackButton: false,
        showDoneButton: true,
        dotsFlex: 3,
        nextFlex: 1,
        back: Icon(Icons.arrow_back),
        skip: Text('Skip',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        next: Icon(Icons.arrow_forward,size: 30,),
        done: Text('Start',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        dotsDecorator: DotsDecorator(
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Color(0xFF376AED),
        ),

      );

  }
}