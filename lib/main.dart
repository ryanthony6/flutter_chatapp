import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String selectedStatus = 'Available';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[300]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 80,
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile_image.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'My Name',
              ),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Your Brief Description',
              ),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text('0123-456-78910'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 'Available',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value.toString();
                    });
                  },
                ),
                Text('Available'),
                SizedBox(width: 20),
                Radio(
                  value: 'Busy',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value.toString();
                    });
                  },
                ),
                Text('Busy'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String bio = bioController.text;
                String status = selectedStatus;
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
