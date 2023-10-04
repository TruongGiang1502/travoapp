import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_demo/features/auth/services/firebase_auth_method.dart';

class ShowDialog {

  static void _removeRem () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('isLogin');
  }

  static void signOutUser(BuildContext context) async {
    _removeRem();
    await FirebaseAuthMethod().signOut(context);
  }

  static void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
         
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                signOutUser(context);
                Navigator.of(context).pop(); 
              },
              child: const Text('Sign out', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  static void showSimpleDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
         
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
