import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({Key? key}) : super(key: key);

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Register Info"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("${FirebaseAuth.instance.currentUser?.email}"),
            Text("${FirebaseAuth.instance.currentUser?.uid}"),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
