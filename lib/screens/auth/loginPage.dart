import 'package:chatapp/screens/auth/auth_services.dart';
import 'package:chatapp/screens/auth/email_verif.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/utils/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formfield = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberMe = false;
  User? user;

  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _showAlertDialog(String message) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
          );
        },
      );
  }

  // sign in with google button on click
  _handleGoogleBtn() {
    auth_service().signInWithGoogle().whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  // sign in with email and passwd
  _handleLoginBtn() async {
    if (_formfield.currentState!.validate()) {
      _formfield.currentState!.save();
      User? user = await auth_service().signInWithEmailAndPassword(email.text, password.text);

      if(user!= null){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
      else{
        _showAlertDialog('Invalid email or password');
      }
    }
  }

  void _handleSignUp () async{
     if (_formfield.currentState!.validate()){
      _formfield.currentState!.save();
   
      User? user = await auth_service().signUpWithEmailAndPassword(email.text, password.text);

      if(user!= null){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Verification()));
      }
      else{
        _showAlertDialog('Email for that user already exists');
      }
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFFFFF),
        body: Form(
          key: _formfield,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Back",
                        style: tTextStyle.copyWith(
                            fontSize: 30, fontWeight: bold)),
                    SizedBox(height: 11),
                    Text(
                      "Welcome to cloudTalk, Please sign in to continue using our app.",
                      style: tTextStyle.copyWith(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Login",
                            style: tTextStyle.copyWith(
                                fontSize: 15, fontWeight: bold)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your E-mail';
                            }
                            else if(!value.contains('@')){
                              return 'Please enter a valid E-mail';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your E-mail",
                            filled: true,
                            fillColor: Color(0xFFe0e0e0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Password",
                                style: tTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold)),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Please enter a valid password (min length 7)';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  filled: true,
                                  fillColor: Color(0xFFe0e0e0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  hintStyle: tTextStyle.copyWith(
                                      fontSize: 15,
                                      color: textColor.withOpacity(0.6)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 17)),
                              obscureText: !isPasswordVisible,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 8),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                                if (_formfield.currentState!.validate()) {
                                  _formfield.currentState!.save();
                                    auth_service().resetPassword(email.text);
                                    _showAlertDialog('Check your email');
                                }
                            },
                            child: Text("Forgot Password ?",
                                style: tTextStyle.copyWith(
                                    fontSize: 13, fontWeight: bold))),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryButtonColor),
                          onPressed: () {
                            _handleSignUp();
                          },
                          child: Text("Login",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 15))),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("OR",
                              style: tTextStyle.copyWith(
                                  fontSize: 12, fontWeight: bold))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryButtonColor,
                        ),
                        onPressed: () {
                          _handleLoginBtn();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                                height: 20),
                            SizedBox(width: 5),
                            Text("Sign In With Google",
                                style:
                                    whiteTextStyle.copyWith(fontWeight: bold))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account yet? ",
                            style: tTextStyle.copyWith(fontSize: 16)),
                        GestureDetector(
                            onTap: () {
                              print("Sign up");
                            },
                            child: Text("Sign up",
                                style: tTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                    color: Colors.blue)))
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
