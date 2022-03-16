import 'package:chatapp3/controllers/authController.dart';
import 'package:chatapp3/views/showMessage_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  AuthController authController = AuthController();
  var message = TextEditingController();
  var storeMessage = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  getCurrentUser(){
    var user = firebaseAuth.currentUser;
    if(user == loginUser){
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(loginUser!.email.toString()),
        actions: [
          IconButton(
              onPressed: () async{
                SharedPreferences prefernces = await SharedPreferences.getInstance();
                authController.signOut(context);
                prefernces.remove('email');
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Message',
              textScaleFactor: 1.3,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 500,),
            ShowMessage(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        hintText: 'Write message',
                        contentPadding: EdgeInsets.only(left: 12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if(message.text.isNotEmpty){
                        storeMessage.collection('Message1').doc().set({
                          'message': message.text.trim(),
                          'user' : loginUser!.email.toString(),
                          'time' : DateTime.now()
                        });
                        message.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
