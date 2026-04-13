import 'package:budget_pro/domain/bloc/login_progress_indicator_cubit.dart';
import 'package:budget_pro/domain/bloc/signup_progress_indicator_cubit.dart';
import 'package:budget_pro/domain/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseAuth get auth {
    return _auth;
  }

  Future<void> signUpUser(
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (confirmTwoPassword(password, confirmPassword)) {
      context.read<SignupProgressIndicatorCubit>().showLoader();
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
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error login user!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        throw Exception("Failed to sing up : $e");
      } finally {
        if (context.mounted) {
          context.read<SignupProgressIndicatorCubit>().hideLoader();
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password does not match!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> logIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      context.read<LoginProgressIndicatorCubit>().showLoader();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.app);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error login user!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      throw Exception("Login failed : $e");
    } finally {
      if (context.mounted) {
        context.read<LoginProgressIndicatorCubit>().hideLoader();
      }
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  bool confirmTwoPassword(String pass_1, String pass_2) {
    if (pass_1 == pass_2) {
      return true;
    }

    return false;
  }
}
