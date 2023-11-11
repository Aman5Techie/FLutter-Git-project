import 'package:chat_app/widget/chat_message.dart';
import 'package:chat_app/widget/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreenClass extends StatelessWidget {
  ChatScreenClass({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Flutter Chat")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                // a();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const Column(
          children: [Expanded(child: ChatMessage()), NewMessage()]),
    );
  }
}
