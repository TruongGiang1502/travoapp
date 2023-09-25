import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/bloc_provider.dart';
import 'package:travo_demo/features/auth/screens/fgpass_screen.dart';
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/features/auth/screens/signup_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/detail_hotel_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/result_hotel_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/select_room_screen.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';
import 'package:travo_demo/screen/onboard/onboard_screen_main.dart';

Route <dynamic> generateRoute (RouteSettings settings){
  switch (settings.name){
    case OnboardScreenMain.routeName:
      return MaterialPageRoute(builder: (context) => const OnboardScreenMain());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
    case SignupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AuthPhoneCodeCubit(),
          child: const SignupScreen(),
        )
      );
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case ResultHotelScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ResultHotelScreen());
    case DetailHotelScreen.routeName:
      final snapandId = settings.arguments as (Map <String, dynamic>, String);
      return MaterialPageRoute(builder: (context) => DetailHotelScreen(snap: snapandId.$1, snapId: snapandId.$2));
    case SelectRoomScreen.routeName:
      final streamsnap = settings.arguments as Stream<QuerySnapshot<Map<String, dynamic>>>;
      return MaterialPageRoute(builder: (context) => SelectRoomScreen(streamsnap: streamsnap));
    case CheckOutScreen.routeName:
      final snap = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (context) => CheckOutScreen(snap: snap));
    default:
      return MaterialPageRoute(builder: (context) => const CircularProgressIndicator());
  }
}