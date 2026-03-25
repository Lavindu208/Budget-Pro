import 'package:budget_pro/domain/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> signUpUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uID = credential.user!.uid;
      await _db.collection('users').doc(uID).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.logIn);
        debugPrint('login');
      }
    } catch (e) {
      throw Exception("Failed to sing up : $e");
    }
  }

  Future<void> logIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.app);
        debugPrint('login');
      }
    } catch (e) {
      throw Exception("Login failed : $e");
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
