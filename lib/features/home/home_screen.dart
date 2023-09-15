import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/services/firebase_auth_method.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signOutUser(BuildContext context) async {
    await FirebaseAuthMethod().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        actions: [
          IconButton(
            onPressed: (){
              signOutUser(context);
            }, 
            icon: const Icon(Icons.logout)
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.settings),)
        ],
      ),
    );
  }
}