import 'package:chatapp3/views/chatScreen_page.dart';
import 'package:chatapp3/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void googleSignIn(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ChatScreenPage()),
          (route) => false);
    }
  }

  void register(context, email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      showError(context, e);
    }
  }

  void loginUser(context, email, password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatScreenPage()));
    } catch (e) {
      showError(context, e);
    }
  }

  void signOut(context) async {
    try {
      await firebaseAuth.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    } catch (e) {
      showError(context, e);
    }
  }

  void showError(context, e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error message'),
              content: Text(e.toString()),
            ));
  }
}
