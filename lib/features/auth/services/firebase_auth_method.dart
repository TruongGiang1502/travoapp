import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/auth/utils/show_snackbar.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth;
  FirebaseAuthMethod(this._auth);

  //SignUp with email
  Future <void> signupWithEmai({
    required String name,
    required String country,
    required String email,
    required String password,
    required String phoneNumber,
    required BuildContext context
  }) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(error){
      // ignore: use_build_context_synchronously
      showSnackBar(context, error.message!);
    }
  }
}