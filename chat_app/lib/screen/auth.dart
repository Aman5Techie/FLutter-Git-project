// import 'package:chat_app/screen/chat.dart';
import 'dart:io';

import 'package:chat_app/widget/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';/
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance; // give access to firebase object

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() {
    return _AuthscreenState();
  }
}

class _AuthscreenState extends State<Authscreen> {
  var is_login = true;
  var _enteremail = '';
  var _enterpass = '';
  var _username = '';
  var _isauthenticating = false;
  File? _pickedimage;
  final TextEditingController pass1 = TextEditingController();
  final TextEditingController pass2 = TextEditingController();
  final _form = GlobalKey<FormState>();

  // void me() { // dont make unneccesary methods you can directylr use setstate there
  //   setState(() {
  //     is_login = !is_login;
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    pass1.dispose();
    pass2.dispose();
    super.dispose();
  }

  void _submit() async {
    final is_valid = _form.currentState!.validate();

    if (!is_valid) {
      return;
    }

    if (!is_login && _pickedimage == null) {
      return;
    }

    if (pass1.text != pass2.text && !is_login) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password dont match")));
      return;
    }
    _form.currentState!.save();
    _form.currentState!.reset();
    try {
      setState(() {
        _isauthenticating = true;
      });
      if (is_login) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteremail, password: _enterpass);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login")));

        // Navigator.push(context, MaterialPageRoute(builder: (ss)=>ChatScreenClass()));

        // print("Login Succeess");
      } else {
        final user = await _firebase.createUserWithEmailAndPassword(
            email: _enteremail, password: _enterpass);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sign Uped")));
        final strogeref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child("${user.user!.uid}.jpg");
        await strogeref.putFile(_pickedimage!);
        final imageurl = await strogeref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.user!.uid)
            .set({
          'username': _username,
          'email': _enteremail,
          'image_url': imageurl,
        });

        print(imageurl);
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message ?? "Authentication Failed"),
      ));
      setState(() {
        _isauthenticating = false;
      });
    }

    pass1.clear();
    pass2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              width: 200,
              child: Image.asset("assests/chat.png"),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!is_login)
                            UserImagePicker(
                              onpickedimage: (pickedimage) {
                                _pickedimage = pickedimage;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Email Address"),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return 'Please Enter valid email id';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteremail = newValue!;
                            },
                          ),
                          if (!is_login)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Username"),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please Enter at least 4 charater';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _username = newValue!;
                              },
                            ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Password"),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password should be greater than 6";
                              }
                              return null;
                            },
                            controller: pass1,
                            onSaved: (newValue) {
                              _enterpass = newValue!;
                            },
                          ),
                          !is_login
                              ? TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Reenter Password"),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return "Password should be greater than 6";
                                    }
                                    if (value != pass1.text) {
                                      return "Password dont match";
                                    }

                                    return null;
                                  },
                                  controller: pass2,
                                  // onSaved: (newValue) {
                                  //   _enterpass = newValue!;
                                  // },
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isauthenticating)
                            const CircularProgressIndicator(),
                          if (!_isauthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Text(is_login ? 'Login' : "Sign Up"),
                            ),
                          if (!_isauthenticating)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    is_login = !is_login;
                                  });
                                },
                                child: Text(is_login
                                    ? "Create a account"
                                    : "Login in account"))
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
