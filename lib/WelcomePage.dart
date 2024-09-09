import 'package:flutter/material.dart';
import 'theme.dart'; 


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Image.asset(
              "assets/images/login_logo.png",
            ),      
            SizedBox(height: 20),
            Text(
              'Welcome to Our E-Commerce App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(height: 10),
            Text(
              'An e-commerce app sells various products with suitable prices and brilliant offers.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: brown),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
