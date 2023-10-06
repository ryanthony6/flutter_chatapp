import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/ChatDetails.dart';
import 'package:chatapp/Pages/Chats.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/utils/dateUtil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  final ChatUser user;

  const ConversationList({super.key, required this.user});

  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  Message? message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ChatPage(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessages(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                message = list[0];
              }
              
              return ListTile(
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
                    message != null
                        ? message!.type == Type.image
                            ? 'image'
                            : message!.msg
                        : widget.user.about,
                    maxLines: 1),
                trailing: message == null ? null : 
                Text(
                  dateUtil.getLastMessageTime(context: context, time: message!.sent),
                  style: TextStyle(color: Colors.black54),
                ),
              );
            },
          )),
    );
  }
}
