import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBar (BuildContext context, String text){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
}
