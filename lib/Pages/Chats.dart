import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chats"),
        backgroundColor: Color(0xFF376AED),
      ),
      body: Center(child: Text("tess doang aku")),
    );
  }
}
