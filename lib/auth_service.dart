import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_application/home.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }

  Future<String> signIn({String email, String password}) async {
    try {
      final currentUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return currentUser.user.email;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String username, String email, String password}) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await currentUser.user.updateProfile(displayName: username);
    await currentUser.user.reload();

    return currentUser.user.email;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
