import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/APIs.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/chatUserModel.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user;

  const ChatPage({super.key, required this.user});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.user.name,
                    style:TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    )),
                    SizedBox(height: 2,),
                    const Text('Offline',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: StreamBuilder(
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  //return const Center(child: CircularProgressIndicator());
          
                case ConnectionState.active:
                case ConnectionState.done:
                  // final data = snapshot.data?.docs;
                  // list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                  //     [];
          
                  final list = ['hi'];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                    
                        itemCount: list.length,
                        padding: EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return Text('Messages: ${list[index]}');
                        });
                  }
                  else{
                    return Center(
                      child: Text('Start Chatting',
                      style: TextStyle(fontSize: 20),),
                    );
                  }
              }
            }),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .01, horizontal:MediaQuery.of(context).size.width * .025 ),
            child: Row(
              children: [
                // input field button
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon
                          (Icons.emoji_emotions),color: Color(0xFF376AED)),
                  
                        Expanded(child: TextField(
                          keyboardType:TextInputType.multiline ,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Chat Now!',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                          ),
                        )),
                  
                  
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon
                          (Icons.image),color: Color(0xFF376AED)),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon
                          (Icons.camera_alt),color: Color(0xFF376AED)),


                        SizedBox(width: 5,)
                      ],
                    ),
                  ),
                ),
          
          
                // send button
                MaterialButton(
                  onPressed: (){},
                  minWidth: 0,
                  padding: EdgeInsets.only(top: 10,bottom: 10,right: 5,left: 5),
                  shape: const CircleBorder(),
                  child: Icon(Icons.send,size: 28, color: Colors.white,),
                  color: Colors.red,
                  )
               
                
          
          
          
          
          
              ],
            ),
          )
        ],
      ),
    );
  }
}
