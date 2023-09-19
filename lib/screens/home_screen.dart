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


