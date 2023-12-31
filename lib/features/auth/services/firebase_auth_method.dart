import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/auth/models/user.dart' as model;
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/features/auth/utils/show_snackbar.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuthMethod();

  Future<model.Users> getUserDetails() async {
    User currenrUser = _auth .currentUser!;
    DocumentSnapshot documentSnapshot = 
      await _firestore.collection('user').doc(currenrUser.uid).get();
    return model.Users.fromSnap(documentSnapshot);
  }

  ////SignUp with email
  Future <void> signupWithEmail({
    required String username,
    required String country,
    required String email,
    required String password,
    required String phoneNumber,
    required BuildContext context
  }) async {
    String res = "sign_up_success".tr();
    try{
      UserCredential credUser = 
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
      model.Users user = model.Users(
        email: email, 
        uid: credUser.user!.uid, 
        username: username, 
        country: country, 
        phoneNumber: phoneNumber
      );
      await _firestore.collection('user').doc(credUser.user!.email).set(user.toJson());
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, res);
    } on FirebaseAuthException catch(error){
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, error.message!);
    }
  }

  ////login with email 
  Future <void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, 'Login sucess');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
    } on FirebaseAuthException catch(error){
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, error.message!);
    }
  }

  ////Sign out
  Future<void> signOut(BuildContext context) async {
    try{
      await _auth.signOut();
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, 'Signed Out');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    } on FirebaseAuthException catch(error){
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, error.message!);
    }
  }

  ////Delete user
  // Future<void> deleteUser(BuildContext context) async {
  //   try {
  //     await _auth.currentUser!.delete();
  //      // ignore: use_build_context_synchronously
  //      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  //   } on FirebaseAuthException catch (error){
  //     // ignore: use_build_context_synchronously
  //     ShowSnackBar.showSnackBar(context, error.message!);
  //   }
  // }

  ////reset password
  Future<void> resetPassWord(BuildContext context,  String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (error){
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, error.message!);
    }
  }

}

