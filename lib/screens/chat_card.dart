
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatCard extends StatefulWidget {
  const chatCard({super.key});

  @override
  State<chatCard> createState() => _chatCardState();
}

class _chatCardState extends State<chatCard> {
  @override
  Widget build(BuildContext context) {

    return 
      Card(
      
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01 ,vertical: 3),
      elevation: 0.5,
      // color: Color(0xFFAED2FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    
      child: 
      InkWell(
        
        onTap: (){},
        child: const ListTile(

          leading: CircleAvatar(child: Icon(CupertinoIcons.person),
            ),
        
          title: Text('Bandung Santoso'),

          subtitle: Text('Hallo good morning',maxLines: 1),

          trailing: Text(
            '12.00 PM',
            style: TextStyle(
              color: Colors.black54
            ),
          ),
        ),
      ),
    );
  }
}