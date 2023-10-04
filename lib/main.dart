import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign Up', style: TextStyle(fontSize: 24.0))),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create Your Account',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Nama Depan'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Nama Belakang'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'XX/MM/YYYY'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: passwordController,
              onChanged: (_) => checkInput(),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Retype Password'),
              obscureText: true,
              controller: retypePasswordController,
              onChanged: (_) => checkInput(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isButtonEnabled ? () => signUp() : null,
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    if (passwordController.text == retypePasswordController.text &&
        passwordController.text.isNotEmpty &&
        retypePasswordController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  void signUp() {
    // Implementasi logika pendaftaran di sini
  }
}
