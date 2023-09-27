import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts",),
       centerTitle: true,
       backgroundColor: Color(0xFF376AED),),
      body: Center(child: Text("Contacts Screen")),
    );
  }
}