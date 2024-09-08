// ignore_for_file: prefer_const_constructors

import 'package:graduation_project/models/cart_provider.dart';
import 'package:graduation_project/product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
      ],
      child: MaterialApp(
        home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return const ProductScreen();
              } else {
                return LoginScreen();
              }
            })),
      ),
    ),
  );
}
