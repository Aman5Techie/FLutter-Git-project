import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  var _messagecontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _messagecontroller.dispose();
    super.dispose();
  }

  void _submitmessage() async {
    final entertext = _messagecontroller.text;
    if (entertext.trim().isEmpty) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser!;
    FocusScope.of(context).unfocus();

    final data =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _messagecontroller.text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': data.data()!['username'],
      'userimage': data.data()!['image_url']
    });

    _messagecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            controller: _messagecontroller,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: "text a message"),
          )),
          IconButton(
            onPressed: _submitmessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
