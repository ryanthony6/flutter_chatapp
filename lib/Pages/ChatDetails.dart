import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/messageCard.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/chatUserModel.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user;

  const ChatPage({super.key, required this.user});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> _list = [];

  final _textController = TextEditingController();
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF376AED),
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.user.image,
                          width: 50,
                          height: 50,
                          errorWidget: (context, url, error) =>
                              CircleAvatar(child: Icon(Icons.person)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.user.name,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          SizedBox(
                            height: 2,
                          ),
                          const Text('Offline',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFDAFFFB),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllMessages(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          //return const Center(child: CircularProgressIndicator());

                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  itemCount: _list.length,
                                  padding: EdgeInsets.only(top: 10),
                                  itemBuilder: (context, index) {
                                    return MessageCard(message: _list[index]);
                                  });
                            } else {
                              return Center(
                                child: Text(
                                  'Start Chatting',
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }
                        }
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01,
                      horizontal: MediaQuery.of(context).size.width * .025),
                  child: Row(
                    children: [
                      // input field button
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              // emoji button
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      _showEmoji = !_showEmoji;
                                    });
                                  },
                                  icon: Icon(Icons.emoji_emotions),
                                  color: Color(0xFF376AED)),
                              Expanded(
                                  child: TextField(
                                controller: _textController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: 'Chat Now!',
                                    hintStyle:
                                        TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              )),

                              // image button
                              IconButton(
                                  onPressed: () async {
                                    final ImagePicker picker = ImagePicker();

                                    // Picking multiple images
                                    final List<XFile> images = await picker
                                        .pickMultiImage(imageQuality: 70);

                                    // uploading & sending image one by one
                                    for (var i in images) {
                                      log('Image Path: ${i.path}');
                                      await APIs.sendImage(
                                          widget.user, File(i.path));
                                    }
                                  },
                                  icon: Icon(Icons.image),
                                  color: Color(0xFF376AED)),

                              // take image from camera button
                              IconButton(
                                  onPressed: () async {
                                    final ImagePicker picker = ImagePicker();

                                    // Pick an image
                                    final XFile? image =
                                        await picker.pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 70);
                                    if (image != null) {
                                      log('Image Path: ${image.path}');

                                      await APIs.sendImage(
                                          widget.user, File(image.path));
                                    }
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded,
                                      color: Color(0xFF376AED), size: 26)),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),

                      // send button
                      MaterialButton(
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            APIs.sendMessage(
                                widget.user, _textController.text, Type.text);
                            _textController.text = '';
                          }
                        },
                        minWidth: 0,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 5, left: 5),
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.send,
                          size: 28,
                          color: Colors.white,
                        ),
                        color: Color(0xFF376AED),
                      )
                    ],
                  ),
                ),
                if (_showEmoji)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
