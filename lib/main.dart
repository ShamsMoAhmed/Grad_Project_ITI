// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project/favorite_provider.dart';
import 'package:graduation_project/registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/WelcomePage.dart';
import 'package:graduation_project/models/cart_provider.dart';
import 'package:graduation_project/product_screen.dart';
import 'package:graduation_project/theme.dart';
import 'package:graduation_project/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CartProvider(),
          
        ),
         ChangeNotifierProvider(create: (_) => FavoriteProvider()),

      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: theme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If the user is authenticated, navigate to the product screen
              return ProductScreen();
            } else {
              // If the user is not authenticated, navigate to the welcome page
              return WelcomePage();
            }
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/product': (context) => ProductScreen(),
        },
      ),
    );
  }
}
