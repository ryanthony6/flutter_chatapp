import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Chat App"),
            
            backgroundColor: Colors.blueAccent,
          ),
          body: Center(
            child: 
              TextField(
                decoration: 
                  InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Coba ketik',
                  ),
              ),
           ),
        ),
    );
  }
}
