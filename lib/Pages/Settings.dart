import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/loginPage.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF376AED),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.symmetric(horizontal: 28),
              onPressed: () {
                auth_service().signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              icon: Icon(
                Icons.logout,
                size: 25,
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.settings_applications,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            editProfileOption(context, 'Edit Profile'),
            changePasswordOption(context, 'Change Password'),
          ],
        ),
      ),
    );
  }

  GestureDetector editProfileOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }

  GestureDetector changePasswordOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your password has been reset, check your email")
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text('Close'))
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
