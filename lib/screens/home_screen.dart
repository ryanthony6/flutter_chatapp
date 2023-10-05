import 'package:chatapp/Pages/Chats.dart';
import 'package:chatapp/Pages/Contacts.dart';
import 'package:chatapp/Pages/Settings.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final _screens = [
    ChatsScreen(),
    ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF376AED),
        unselectedItemColor: Color(0xFF868789),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_sharp, size: 20),
            label: "Chats",
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 20),
            label: "Contact",
          ),
        ],
      ),
    );
  }
}
