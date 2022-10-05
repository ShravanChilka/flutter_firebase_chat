import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccount(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}
