import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF376AED),
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          addActionButton()
        ],
      ),

      body: Container(
        child: ElevatedButton(
          child: Text('PRESS TO LOGOUT'),
          onPressed: (){
            auth_service().signOut().then((value){
              print("signed out bitch");
              Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (_) => LoginPage()
      ));

            });
            
          },
        ),
      ),
    );
  }


  Widget addActionButton(){
    return new Container(
      child: 
       IconButton(
          padding: EdgeInsets.symmetric(horizontal: 28),
          onPressed: (){},
          icon: Icon(
            Icons.search,
            size: 30,
          )
       ),
      );
  }





}


