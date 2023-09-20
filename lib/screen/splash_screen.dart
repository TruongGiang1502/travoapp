import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';
import 'package:travo_demo/screen/onboard/onboard_screen_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future <void> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final saveEmail = prefs.getString('email');
    final savePass = prefs.getString('password');
    final saveCheckLogged = prefs.getBool('isLogin');

    if(saveEmail != null && savePass != null && saveCheckLogged == true){
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false);
    } else {
       // ignore: use_build_context_synchronously
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OnboardScreenMain()), (route) => false);
    }
    
  }
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(
      const Duration(seconds: 2),
      (){
         _isLoggedIn();
      }
    );

    return const Image(
      image: AssetImage('images/splashscreen.png'),
      fit: BoxFit.cover,
    );
  }
}
