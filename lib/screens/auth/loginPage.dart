import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/utils/Constant.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Welcome Back",
                  style: tTextStyle.copyWith(fontSize: 30, fontWeight: bold)),
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
                      style:
                          tTextStyle.copyWith(fontSize: 15, fontWeight: bold)),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFe0e0e0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your email",
                          hintStyle: tTextStyle.copyWith(
                              fontSize: 15, color: textColor.withOpacity(0.6)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17)),
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFe0e0e0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter your password",
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
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: rememberMe ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: rememberMe
                                ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Remember me",
                        style: tTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        print("Forgot Password");
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
                    backgroundColor: primaryButtonColor
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (_) => HomeScreen()
                    ));
                  },
                  child: Text("Login",
                      style: whiteTextStyle.copyWith(fontWeight: bold,fontSize: 15))
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR",
                        style:
                            tTextStyle.copyWith(fontSize: 12, fontWeight: bold))
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
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                          height: 20),
                      SizedBox(width: 5),
                      Text("Sign In With Google",
                          style: whiteTextStyle.copyWith(fontWeight: bold))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account yet? ",
                      style: tTextStyle.copyWith(fontSize: 14)),
                  GestureDetector(
                      onTap: () {
                        print("Sign up");
                      },
                      child: Text("Sign up",
                          style: tTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                              color: Colors.blue)))
                ],
              ),
            ]),
          ),
        ));
  }
}
