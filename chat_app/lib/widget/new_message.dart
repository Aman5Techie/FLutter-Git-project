import 'package:chat_app/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticateuser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatsnapshot) {
          // chatsnapdhot gives the object that was loaded in the backend
          if (chatsnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!chatsnapshot.hasData || chatsnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No message found ---------- "),
            );
          }
          if (chatsnapshot.hasError) {
            return const Center(
              child: Text("Something Went wrong ........."),
            );
          }
          final loadedmessage = chatsnapshot.data!.docs;

          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
              reverse: true, // list go bottom to top
              itemCount: loadedmessage.length,
              itemBuilder: (ctx, index) {
                final chatmessage = loadedmessage[index].data();
                final nextchatmessage = index + 1 < loadedmessage.length
                    ? loadedmessage[index + 1].data()
                    : null;
                final cureentUserid = chatmessage['userId'];
                final nextUserid =
                    nextchatmessage != null ? nextchatmessage['userId'] : null;

                final is_same = cureentUserid == nextUserid;

                if (is_same) {
                  return MessageBubble.next(
                      message: chatmessage['text'],
                      isMe: authenticateuser.uid == cureentUserid);
                } else {
                  return MessageBubble.first(
                      userImage: chatmessage['userimage'],
                      username: chatmessage['username'],
                      message: chatmessage['text'],
                      isMe: authenticateuser.uid == cureentUserid);
                }
              });
        });
  }
}
