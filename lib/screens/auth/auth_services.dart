import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class auth_service {

  // google sign in
  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

  // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign out function 
  signOut() async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  // sign up with email and pass
  Future<User?> signUpWithEmailAndPassword(String email, password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
        print(e);
    }
  }

   // sign in with email and pass
  signInWithEmailAndPassword(String emailS, passwordS) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailS,
        password: passwordS,
      );
      return credential.user;
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("The email is wrong");
        
      } else if (e.code == 'wrong-password') {
        print("The password is wrong");
      }
    }
  }

  // reset password 
  resetPassword(String emailReset) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailReset);
    }
    catch (e){
      print('error');
    }
  }

  // email verification
  emailVerif() async{
    try{
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
    catch(e){
      print('error');
    }
  }

  // delete user
  removeUser() async{
     await FirebaseAuth.instance.currentUser?.delete();
  }


}