import 'package:chatapp/Pages/ChatDetails.dart';
import 'package:chatapp/Pages/Chats.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget{
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
        onTap: (){

        },
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.people_outline)),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1,),
          trailing: Text(
            "12.00 PM",
            style: TextStyle(color:  Colors.black54),
          ),

        ),
      ),
    );
   
    
  }
}