// ignore_for_file: prefer_const_constructors

import 'package:graduation_project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final fullNameController = TextEditingController();
  bool _obscureText= true;

  void register() async {
    Auth auth = Auth();
    try {
      var res = await auth.registerNewUser(
          email: emailController.text, password: passwordController.text);
      if (res.user == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your account has not created"),
            ),
          );
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: firstNameController,
                decoration:InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                label: Text("First Name"),
                ),
                
              ),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: fullNameController,
                  decoration:InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText:"Full Name",
                  label: Text("Full Name"),
                  ),
                  
                ),
            ),
            
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                
                controller: emailController,
                decoration: InputDecoration(
                  
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    icon: Icon(
                      Icons.email_sharp,
                      size: 30,
                    ),
                    hintText: "please write your Email or phone number",
                    label: Text("Email or phone number")),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),  // Lock icon as prefix
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;  
            });
          },
        ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    icon: Icon(
                      Icons.lock,
                      size: 30,
                    ),
                    hintText: "please write your Password",
                    label: Text("Password")),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                register();
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
