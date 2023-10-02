import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleMessageSend(String messageText) {
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: messageText,
          isUser: true, // Set to false for received messages
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const SizedBox(width: 10),
            ClipOval(
              child: Image.asset(
                'assets/default.jpg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                ),
            ),
            const SizedBox(width: 10,),
            const Text('Nama')
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                    onSubmitted: _handleMessageSend,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _handleMessageSend(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final messageWidget = Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue : Colors.grey[300],
        borderRadius: isUser
            ? BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: messageWidget,
    );
  }
}