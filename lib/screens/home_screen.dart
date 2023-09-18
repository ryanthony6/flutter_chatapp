import 'package:chatapp/screens/chat_card.dart';
import 'package:flutter/cupertino.dart';
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
        
        leading: const Icon(CupertinoIcons.home),
        title: const Text('cloudTalk'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {}, child: Icon(Icons.add_comment_rounded)),
      ),
      body: ListView.builder(
          itemCount: 11,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const chatCard();
          }),
    );
  }
}
