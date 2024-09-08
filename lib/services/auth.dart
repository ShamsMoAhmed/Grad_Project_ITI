import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final fireAuth = FirebaseAuth.instance;
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, 
      required String password}) {
    return fireAuth.signInWithEmailAndPassword(
        email: email,
         password: password);
  }


  Future<UserCredential> registerNewUser(
      {required String email, 
      required String password}) {
    return fireAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password);
  }

  Future<void> logOut() async {
    await fireAuth.signOut();
  }
}
