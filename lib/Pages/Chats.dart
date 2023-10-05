import 'dart:convert';
import 'dart:developer';

import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/Settings.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:chatapp/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsScreen extends StatefulWidget {

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  
  
  List<ChatUser> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfInfo();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF376AED),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Settings"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            } else if (value == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text("Are you sure want to sign out?")],
                      ),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          onPressed: () {
                            auth_service().signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                                (route) => false);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  });
            }
          }),
        ],
      ),
      body: StreamBuilder(
          stream: APIs.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];

                if (list.isNotEmpty) {
                  return ListView.builder(
                  
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        return ConversationList(user: list[index]);
                      });
                }
                else{
                  return Center(
                    child: Text('No Connections Found',
                    style: TextStyle(fontSize: 20),),
                  );
                }
            }
          }),
    );
  }
}
