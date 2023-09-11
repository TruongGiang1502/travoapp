import 'package:flutter/material.dart';
import 'package:travo_demo/screen/onboard/onboard_screen_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(
      const Duration(seconds: 3),
      (){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardScreenMain())
        );
      }
    );

    return const Image(
      image: AssetImage('images/splashscreen.png'),
      fit: BoxFit.cover,
    );
  }
}
