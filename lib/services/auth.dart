import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future signUp({@required String email, @required String password}) async {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future signIn({@required String email, @required String password}) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
