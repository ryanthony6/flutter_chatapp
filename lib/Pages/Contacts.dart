import 'package:chatapp/API/APIs.dart';
import 'package:chatapp/Pages/ChatDetails.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {

  
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  
  List allResults = [];
  List resultLists = [];
  final search = TextEditingController();


  @override
  void initState() {
    search.addListener(onSearchChanged);
    super.initState();
  }

  searchResultLists(){
    var showResults = [];
    if(search.text != ''){
      for(var clientSnapShot in allResults){
        var name = clientSnapShot['name'].toString().toLowerCase();
        if(name.contains(search.text.toLowerCase())){
          showResults.add(clientSnapShot);
        }
      }
    }
    else{
      showResults = List.from(allResults);
    }

    setState(() {
      resultLists = showResults;
    });
  }


  onSearchChanged() {
    print(search.text);
    searchResultLists();
  }


  getClientStream() async{
    try{
    var data = await FirebaseFirestore.instance.collection('users').orderBy('name').get();
       
    setState(() {
      allResults = data.docs;
    });
    searchResultLists();
    }
    catch (e){
      print('error');
    }
  }

  @override
  void dispose() {
    search.removeListener(onSearchChanged);
    search.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF376AED),
        title: CupertinoSearchTextField(
          backgroundColor: Color(0xFFe0e0e0),
          controller: search,

        ),
      ),


      body:  ListView.builder(
            itemCount: resultLists.length,
            itemBuilder: (context,index){
              return ListTile(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));

                },
                title: Text(resultLists[index]['name']),
                subtitle: Text(resultLists[index]['email']),
                trailing: Icon(Icons.chat)
              );



              

            })
     

    );



  }
}
