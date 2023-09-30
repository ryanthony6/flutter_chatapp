import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/ChatDetails.dart';
import 'package:chatapp/Pages/Chats.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  final ChatUser user;

  const ConversationList({super.key, required this.user});

  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {

  @override
  Widget build(BuildContext context) {
    return Card(
  
      
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatPage(user: widget.user)));
        },
        child: ListTile(
          leading:
         // CircleAvatar(child: Icon(Icons.people_outline)),
              ClipOval(
                
              child: CachedNetworkImage(
                
              imageUrl: widget.user.image,
              width: 50,
              height: 50,
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Text(
            "12.00 PM",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
