// ignore_for_file: prefer_const_constructors

import 'package:graduation_project/registration_screen.dart';
import 'package:graduation_project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText=true;
  void login() async {
    Auth auth = Auth();
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        
      );
            Navigator.pushReplacementNamed(context, '/product');

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/images/login_logo.png",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
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
              _obscureText = !_obscureText;  // Toggle password visibility
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
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text("Login"),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: Text("Register"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
