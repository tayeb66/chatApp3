import 'package:chatapp3/views/chatScreen_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  const ShowMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Message1')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: loginUser!.email == documentSnapshot['user']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(documentSnapshot['message']),
                  Text(
                    documentSnapshot['user'],
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
