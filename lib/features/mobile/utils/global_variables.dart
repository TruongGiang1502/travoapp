import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/favorite/favorite_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/home_screen.dart';
import 'package:travo_demo/features/mobile/screen/payment/payment_screen.dart';
import 'package:travo_demo/features/mobile/screen/user/user_screen.dart';

List <Widget> mainScreenItems = [
  const HomeScreen(),
  const FavoriteScreen(),
  const PaymentScreen(),
  const UserScreen()
];