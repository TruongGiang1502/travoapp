import 'package:flutter/material.dart';
import 'package:travo_demo/features/home/screen/setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        centerTitle: true,
        actions: [

          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}