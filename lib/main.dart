
import 'package:flutter/material.dart';
import 'package:chatapp/ChatPage.dart';



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen());
  }
}

// Main tes buat akses chatpage
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chat App"),
          backgroundColor: const Color.fromARGB(255, 68, 138, 255),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage()));
                },
                child: const Text('ChatPage'),
              )
            ],
          ),
        ),
      ),

    );
  }
}